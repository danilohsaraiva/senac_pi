USE hotel;
-- *****************************************************
-- *                      DESPESAS      	           *
-- *****************************************************
-- Somar despesas por categoria

DELIMITER §
	CREATE PROCEDURE expenditure (type VARCHAR (45))
	BEGIN
		SET @type = type;
        SELECT c.value, c.date, c.description FROM control as c
			INNER JOIN control_types as c_t ON c_t.id= c.type
				WHERE c_t.type = @type;
    END§
DELIMITER ;

CALL expenditure('Energia Eletrica');

-- *****************************************************
-- *            	     PROCEDURES 	     	       *
-- *****************************************************
-- create procedure apra verificar os valores...

DELIMITER §
	CREATE PROCEDURE total_value(id_book_hotel INT)
	BEGIN
		SET @id = id_book_hotel;
        
		SELECT SUM(
		(SELECT SUM(
		-- Soma restaurante
		IFNULL((SELECT SUM(s_r.qty*m_r.value) FROM book_hotel as b_h  
			INNER JOIN service_restaurant as s_r ON b_h.id = s_r.service_order_id
				INNER JOIN menu_restaurant as m_r ON m_r.id= s_r.menu_id
					WHERE b_h.id= @id),0))
		+
		-- Soma lavanderia
		IFNULL((SELECT SUM(l.value* s_l.qty) FROM book_hotel as b_h 
			INNER JOIN service_laundry as s_l ON s_l.service_order_id = b_h.id
				INNER JOIN laundry as l ON l.id = s_l.laundry_id
					WHERE b_h.id= @id),0))
		   + 
		-- Valor referente aos dias hospedados sem contabilizar check-out atrasados
		(SELECT (
		IFNULL((SELECT (DATEDIFF(a_c.check_out, a_c.check_in) * t_r.value ) FROM book_hotel as b_h 
			INNER JOIN costumer_to_accommodation as c_a ON b_h.id= c_a.book_hotel_id
				INNER JOIN accommodation as a_c ON a_c.id = c_a.accommodation_id
					INNER JOIN room as rm ON a_c.room_id = rm.id
						INNER JOIN type_room as t_r ON rm.type_room_id = t_r.id
							WHERE b_h.id=@id
								GROUP BY b_h.id),0)
		-
		-- Valor pago para reserva
		IFNULL((SELECT ((DATEDIFF(date_to_checkout, date_to_checkin) * t_r.value)*0.3) FROM book_hotel as b_h 
			INNER JOIN type_room as t_r ON b_h.type_room_id = t_r.id
				WHERE b_h.id =@id),0)

		))) as 'Valor Total';
    END §
DELIMITER ;

CALL total_value(6);

-- *****************************************************
-- *              30% VALOR DA HOSPEDAGEM     	       *
-- *****************************************************
-- Necessário para check-in
DELIMITER §
	CREATE PROCEDURE price_to_book_hotel(id_entrada INT, needed_percent INT)
		BEGIN
			SET @value = needed_percent;
			SET @id = id_entrada;
			
			SELECT ((DATEDIFF(date_to_checkout, date_to_checkin) * t_r.value)*(@value/100)) as 'Valor Necessário para Reserva'FROM book_hotel as b_h 
			INNER JOIN type_room as t_r ON b_h.type_room_id = t_r.id
				WHERE b_h.id =@id;
		END§
DELIMITER ;

CALL price_to_book_hotel(1,30); -- Professor eu preciso arredondar este valor aqui, ou posso deixar pra fazer por meio das linguagens de programação em si?
								-- Outra dúvida, eu preciso adicionar o resultado destas queries a uma variavel Out? pra ser usada posteriormente no back-end com a linguagem de programação?

-- *****************************************************
-- *              VALOR TOTAL RESTAURANTE      	       *
-- *****************************************************

DELIMITER §
	CREATE PROCEDURE value_restaurant(id_book_hotel INT)
	BEGIN
	SET @id = id_book_hotel;
		SELECT (IFNULL((SELECT SUM(s_r.qty*m_r.value)  as 'Valor Restaurante' FROM book_hotel as b_h  
			INNER JOIN service_restaurant as s_r ON b_h.id = s_r.service_order_id
				INNER JOIN menu_restaurant as m_r ON m_r.id= s_r.menu_id
					WHERE b_h.id = @id),0)) as 'Valor Restaurante';
     END §   
DELIMITER ;

CALL value_restaurant(8);

-- *****************************************************
-- *          		    LAVANDERIA	        	       *
-- *****************************************************
DELIMITER §
	CREATE PROCEDURE value_laundry(id_book_hotel INT)
	BEGIN
    SET @id = id_book_hotel;
		SELECT (IFNULL((SELECT SUM(l.value* s_l.qty) FROM book_hotel as b_h 
			INNER JOIN service_laundry as s_l ON s_l.service_order_id = b_h.id
				INNER JOIN laundry as l ON l.id = s_l.laundry_id
					WHERE b_h.id= @id),0)) as 'Valor Lavanderia';
	END §
DELIMITER ;

CALL value_laundry(3);


-- *****************************************************
-- *            CALCULAR GASTOS POR PERIODO 	       *
-- *****************************************************

DELIMITER §
	CREATE PROCEDURE looking_for(date1 DATE, date2 DATE) -- Eu queria deixar esse campo DEFAULT pra monta meu raciocínio, mas o MySql não possibilita deixar paramentro como tal 
	BEGIN
	SET @date1 = date1;
    SET @date2 = date2;

		SELECT c.value as 'Valor', c.date as 'Data', c.description as 'Descrição' FROM control as c
			INNER JOIN control_types as c_t ON c_t.id= c.type
				WHERE date>= date1 and date <=@date2;
	END § 
DELIMITER ;

CALL looking_for( '2021-01-01','2021-09-01');


-- *****************************************************
-- *            	     FUNCTION    	     	       *
-- *****************************************************
-- Aplicando desconto
DELIMITER §
	CREATE FUNCTION price_with_discount (type_room INT, discount_value INT,date_check_in DATE, date_check_out DATE) -- tipo do quarto, discount (número referente a % de desconto)
    RETURNS DECIMAL (9,2) DETERMINISTIC
	BEGIN
		DECLARE value_room DECIMAL(9,2);
        SET @id = type_room;
        SELECT t_r.value FROM type_room as t_r WHERE t_r.id = @id  INTO value_room;
		RETURN  DATEDIFF(date_check_out,date_check_in)*(value_room - (value_room * (discount_value/100)));
	END §
DELIMITER ;

SELECT price_with_discount(1,30,'2021-08-01','2021-09-11');

-- *****************************************************
-- *            	     TRIGGER    	     	       *
-- *****************************************************
-- Setar status "Ocupado" em status_room -- Partindo do pré suposto que ela só sera alterada novamente no momento do cleck-out...
DELIMITER §
	CREATE TRIGGER care_status_room AFTER INSERT 
    ON hotel.accommodation  -- Se tivesse como especificar qual elemente esta sendo manuseado para este efeito que eu quero.
    FOR EACH ROW
    BEGIN
		UPDATE status_room
        SET free = 0, busy = 1
		WHERE id = NEW.room_id;
    END§
DELIMITER ;

-- Tornar o quarto "Disponível" ao ser realizado o update...
DELIMITER §
	CREATE TRIGGER care_status_out AFTER UPDATE
    ON hotel.accommodation  
    FOR EACH ROW
    BEGIN
		UPDATE status_room	
        SET free = 1, busy = 0
        WHERE id = OLD.room_id;
    END §
DELIMITER ;

-- Bom, imaginei deixar essa parte automática, e deixar o status de manutenção disponivel para auteração na tabela pelo usuário o que refletiria o status, mas tenho de ver a aplicabilidade disto.

DELIMITER §
	CREATE TRIGGER care_status_maintenance AFTER UPDATE
    ON hotel.room
    FOR EACH ROW
    BEGIN
		UPDATE status_room
		SET maintenance = NEW.maintenance
		WHERE id = OLD.number;
    END §
DELIMITER ;


-- Deixei pronto para testar o uso das Triggers... Não sei até que ponto é viável fazer isso... Mas pretendo usar...
-- INSERT INTO accommodation (check_in, room_id) values ('2021-06-01 18:00:00',4);
-- UPDATE accommodation SET check_out ='2021-06-07 18:00:00' WHERE ID = 32;
-- UPDATE room SET maintenance = 1 WHERE room.id = 2;



-- *****************************************************
-- *                 TRIGGER INSERT USER               *
-- ***************************************************** 
DELIMITER §
	CREATE TRIGGER after_insert_user BEFORE INSERT
    ON user_sistem
	FOR EACH ROW
		BEGIN
            SET NEW.password = MD5(NEW.password);
		END §
DELIMITER ;

-- Professor eu não consegui relizar o mesmo processo utilizando  AES_ENCRYPT().