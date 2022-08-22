USE hotel;
-- *****************************************************
-- *                     USER & ROLE       	           *
-- *****************************************************
CREATE ROLE 'role_auditoria';
GRANT UPDATE, DELETE, INSERT, SELECT ON hotel.control TO 'role_auditoria';

-- *****************************************************
-- *                      AUDITORIA                    *
-- *****************************************************

CREATE USER 'auditoria'@'localhost' IDENTIFIED BY 'auditoria';
CREATE ROLE 'role_auditoria';

GRANT SELECT, UPDATE, INSERT, UPDATE ON hotel.control TO 'role_auditoria';
GRANT SELECT ON hotel.book_hotel TO 'role_auditoria';
GRANT SELECT ON hotel.payment TO 'role_auditoria';
GRANT SELECT ON hotel.service_restaurant TO 'role_auditoria';
GRANT SELECT ON	hotel.service_laundry TO 'role_auditoria';

GRANT 'role_auditoria' TO 'auditoria'@'localhost';

FLUSH PRIVILEGES;

SET DEFAULT ROLE 'role_auditoria' TO 'auditoria'@'localhost';
SHOW GRANTS FOR 'auditoria'@'localhost' USING 'role_auditoria';

-- *****************************************************
-- *                    RESTAURANTE                    *
-- *****************************************************

CREATE USER 'restaurante'@'localhost' IDENTIFIED BY 'restaurante';

CREATE ROLE 'role_restaurante';

GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.menu_restaurant	TO 'role_restaurante';
GRANT SELECT, INSERT, UPDATE, DELETE ON hotel.service_restaurant TO 'role_restaurante';
GRANT SELECT ON hotel.book_hotel TO 'role_restaurante';
GRANT INSERT ON hotel.report_payment TO 'role_restaurante'; -- Dúvida: para fazer o pagamento é necessário o n da reserva, que usei como referência, isso implica que o usuario precisa ter acesso a essa tabela pra leitura correto?
GRANT INSERT ON hotel.payment TO 'role_restaurante';

GRANT 'role_restaurante' TO 'restaurante'@'localhost';

FLUSH PRIVILEGES;

SET DEFAULT ROLE 'role_restaurante' TO 'restaurante'@'localhost';
SHOW GRANTS FOR 'restaurante'@'localhost' USING 'role_restaurante';


-- *****************************************************
-- *                    LAVANDERIA                     *
-- ***************************************************** 

CREATE USER 'lavanderia'@'localhost' IDENTIFIED BY 'lavanderia';

CREATE ROLE 'role_lavanderia';

GRANT SELECT, DELETE, UPDATE, INSERT ON hotel.laundry TO 'role_lavanderia';
GRANT SELECT, DELETE, UPDATE, INSERT ON hotel.service_laundry TO 'role_lavanderia';
GRANT SELECT ON hotel.book_hotel TO 'role_lavanderia';
GRANT INSERT ON hotel.report_payment TO 'role_lavanderia';
GRANT INSERT ON hotel.payment TO 'role_lavanderia';

GRANT 'role_lavanderia' TO 'lavanderia'@'localhost';

FLUSH PRIVILEGES;

SET DEFAULT ROLE 'role_lavanderia' TO 'lavanderia'@'localhost';
SHOW GRANTS FOR 'lavanderia'@'localhost' USING 'role_lavanderia';


-- *****************************************************
-- *                    ATENDENTE                      *
-- ***************************************************** 

CREATE USER 'atendente'@'localhost' IDENTIFIED BY 'atendente';

CREATE ROLE 'role_atendente';

GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.book_hotel TO 'role_atendente';
GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.costumer TO 'role_atendente';
GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.address TO 'role_atendente';
GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.phone TO 'role_atendente';

GRANT 'role_atendente'	TO 'atendente'@'localhost';

FLUSH PRIVILEGES;

SET DEFAULT ROLE 'role_atendente' TO 'atendente'@'localhost';
SHOW GRANTS FOR 'atendente'@'localhost' USING 'role_atendente';

-- *****************************************************
-- *                    RECEPCIONISTA                  *
-- ***************************************************** 

CREATE USER 'recepcionista'@'localhost' IDENTIFIED BY 'recepcionista';

CREATE ROLE 'role_recepcionista';

GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.book_hotel TO 'role_recepcionista';
GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.book_hotel TO 'role_recepcionista';
GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.costumer_to_accommodation TO 'role_recepcionista';
GRANT SELECT, DELETE, INSERT, UPDATE ON hotel.accommodation TO 'role_recepcionista';
GRANT UPDATE ON  hotel.room TO 'role_recepcionista'; -- Professor tem algum modo de eu fazer isso a nível de linha?

GRANT 'role_recepcionista' TO 'recepcionista'@'localhost';

FLUSH PRIVILEGES;

SET DEFAULT ROLE 'role_recepcionista' TO 'recepcionista'@'localhost';
SHOW GRANTS FOR 'atendente'@'localhost' USING 'role_atendente';

-- *****************************************************
-- *                       GESTÃO                      *
-- ***************************************************** 
-- Irei criar um usuário que contempla todas permissões, no entando eu li que não é viável
-- Por questão de segurança. Caso eu precise criar um usuário que tenha acesso total ao sistema, no caso de gerente,
-- por exemplo, qual melhor forma de proceder?



CREATE USER 'gestor'@'localhost' IDENTIFIED BY 'gestor';

GRANT ALL ON *.* TO 'gestor'@'localhost';


