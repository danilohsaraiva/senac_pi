-- *****************************************************
-- *                       VIEWS	                   *
-- *****************************************************
USE hotel;
-- Hospedagem do cliente
CREATE VIEW view_costumer_hotel AS
SELECT c.name as Nome, ac.check_in as 'Check-in', ac.check_out as 'Check-out',t_r.type as 'Tipo Quarto', t_r.description as 'Descrição',r.number as 'Número do Quarto'FROM book_hotel as b_h
	INNER JOIN costumer_to_accommodation c_a ON b_h.id = c_a.book_hotel_id
		INNER JOIN accommodation as ac ON ac.id = c_a.accommodation_id
			INNER JOIN room as r ON r.id = ac.room_id
				INNER JOIN type_room as t_r ON t_r.id = r.type_room_id
					INNER JOIN costumer as c ON c.id = c_a.costumer_id
						ORDER BY ac.check_in;

SELECT * FROM view_costumer_hotel;

-- Dados do cliente
CREATE VIEW costumer_informations AS
SELECT c.name as Nome, YEAR(NOW())-YEAR(c.birth_date) as Idade, c.special_needs as 'PcD/PNE', ph.number as 'Telefone',tp.type_phone as Tipo, c.email as 'E-mail' FROM costumer as c
	INNER JOIN costumer_address as c_a ON c.id = c_a.costumer_id
		INNER JOIN address as ad ON c_a.address_id = ad.id
			INNER JOIN contact_costumer as cc ON cc.costumer_id = c.id
				INNER JOIN phone as ph ON ph.id = cc.phone_id
					INNER JOIN type_phone as tp ON tp.id = ph.type_id;

SELECT * FROM costumer_informations;


                    
-- *****************************************************
-- *                       INDEX	                   *
-- *****************************************************
USE hotel;
ALTER TABLE costumer ADD INDEX idx_name_costumer(name);
ALTER TABLE costumer ADD INDEX idx_pcd_pne(special_needs);
                    