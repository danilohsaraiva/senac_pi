-- *****************************************************
-- *              REQUIRED FOR USE SYSTEM      	       *
-- *****************************************************

USE hotel;

-- *****************************************************
-- *                  TYPE OF PAYMENT                  *
-- *****************************************************
INSERT INTO type_of_payment (type) VALUE 
('Cartão de Credito'),
('Cartão de Débito'),
('Pix'),
('Trasferência Bancária'),
('Dinheiro')
;

-- *****************************************************
-- *                   TYPE OF ROOMS         	       *
-- *****************************************************
INSERT INTO  type_room(type, description, value) VALUES
('Quarto Casal','1 Cama Casal','263.00'),
('Quarto Duplo','2 Camas Solteiro','263.00'),
('Quarto Triplo (Casal)','1 Cama Casal e 1 Solteiro','343.00'),
('Quarto Triplo (Solteiro)','3 Camas Solteiro','343.00'),
('Quarto Quadruplo','1 Cama Casal e 2 Solteiro','409.00'),
('Quarto Solteiro','1 Cama Solteiro','150.00')
;

-- *****************************************************
-- *              COLLABORATORS FUNCTIONS      	       *
-- *****************************************************
INSERT INTO collaborator_function (function_collab, description) VALUES 
('Auditor','Auditoria'),
('Atendente de Reserva','Reservas por telefone'),
('Auxíliar de Cozinha','Setor Restaurante'),
('Auxiliar de Lavanderia','Setor Lavanderia'),
('Auxíliar de Limpesa','Setor Limpesa'),
('Chefe de Cozinha','Setor Restaurante'),
('Chefe de Lavanderia','Setor Lavanderia'),
('Governanta(e)','Setor Lavanderia'),
('Gerente','Gestão'),
('Recepcionista','Recepção');


-- *****************************************************
-- *                   MENU RESTAURANT         	       *
-- *****************************************************
INSERT INTO menu_restaurant (name, value, type)
VALUES ('Pão','1.00','Entrada'), 
('Mantenteiga (un)','0.6','Entrada'), 
('Azeitonas','1.00','Entrada'), 
('Chouriço assado','5.50','Entrada'), 
('Alheira','4.50','Entrada'), 
('Morcela','5.00','Entrada'),
('Presunto','6.00','Entrada'),
('Queijo','5.00','Entrada'), 
('Sopa','2.00','Entrada'),
('Costeleta de Vitela','12.00','Carne'),
('Bife de Vitela','8.50','Carne'),
('Entrecosto de Porco Grelhado','7.50','Carne'),
('Alheira a Preto','9.50','Carne'),
('Posta de Vitela','14.00','Carne'),
('Bacalhau à Casa','12.00','Peixe'),
('Bacalhau Assado com Batata a Murro','12.00','Peixe'),
('Cozido à Portuguesa','12.00','Por Encomenda'),
('Cabrito Assado','15.00','Por Encomenda'),
('Cabrito Estufado','15.00','Por Encomenda'),
('Costela Mendinha de Vitela Assada','12.00','Por Encomenda'),
('Aletria','3.00','Sobremesa'),
('Pudim','3.00','Sobremesa'),
('Torta de Amêndoa','3.50','Sobremesa'),
('Bolo de Chocolate','4.00',''),
('Queijo c/ Doce de Abobora','4.00','Sobremesa'),
('Queijo c/ Marmelada','4.00','Sobremesa'),
('Queijo c/ Todos','4.00','Sobremesa'),
('Salada de Fruta','4.00','Sobremesa'),
('Duas Quintas (Douro)','20.00','Vinho Maduro Tinto'),
('Quinta da Carregosa - Resenha (Douro)','18.00','Vinho Maduro Tinto'),
('Aguia Moura - Resenha (Douro)','15.00','Vinho Maduro Tinto'),
('Monte Mayor (Alentejo)','15.00','Vinho Maduro Tinto'),
('Quinta do Sobreiro (Valpaços)','14.00','Vinho Maduro Tinto'),
('Papa Figo (Douro)','14.00','Vinho Maduro Tinto'),
('Montalegre Clássico (Tras-os-Montes)','10.00','Vinho Maduro Tinto'),
('Monte Velho (Alentejo)','10.00','Vinho Maduro Tinto'),
('Requengos Selecção (Alentejo)','9.00','Vinho Maduro Tinto'),
('Altano (Douro)','10.00','Vinho Maduro Tinto'),
('Caiano (Alemtejo)','9.00','Vinho Maduro Tinto'),
('Santa Velha (Valpaços)','9.00','Vinho Maduro Tinto'),
('Cabriz (Dão)','8.50',''),
('Monte Velho 1/2 (Alentejo)','6.00','Vinho Maduro Tinto'),
('Montealegre Clássico (Tras-os-Montes)','10.00',''),
('Santa Velha','10.00','Vinho Maduro Branco'),
('Altano (Douro)','10.00','Vinho Maduro Branco'),
('Monte Velho (Alentejo)','10.00','Vinho Maduro Branco'),
('Soalheiro (Alvarinho)','18.00',''),
('Arca Nova','13.00','Vinhos Verdes/ Brancos / Tintos'),
('Muralhas (Monção','8.50','Vinhos Verdes/ Brancos / Tintos'),
('Matheus Rose','8.00','Vinhos Verdes/ Brancos / Tintos'),
('Ponte da Barca (Tinto)','7.50','Vinhos Verdes/ Brancos / Tintos'),
('Vinhos da Casa ao Copo','2.50','Vinhos da Casa'),
('Maduro Branco 0,75L','6.50','Vinhos da Casa'),
('Verde Tinto','6.50','Vinhos da Casa'),
('Verde Branco','6.50','Vinhos da Casa'),
('Água 0,50L','1.50','Outros'),
('Água 1L','2.00','Outros'),
('Cerveja 0,33L','1.60','Outros'),
('Regrigerantes (Coca-Cola, Fanta, Sprite','1.60','Outros');

-- *****************************************************
-- *                   MENU LAUNDRY         	       *
-- *****************************************************

INSERT INTO laundry (name, value, description) VALUES
('Batina','29.00','Lavar e Passar'),
('Bermuda','9.00','Lavar e Passar'),
('Blazer','29.50','Lavar e Passar'),
('Blusa','9.00','Lavar e Passar'),
('Blusão','17.00','Lavar e Passar'),
('Bombacha','18.00','Lavar e Passar'),
('Calça algodão','10.00','Lavar e Passar'),
('Calça','16.00','Lavar e Passar'),
('Camisa Social','12.50','Lavar e Passar'),
('Camisa Polo','9.00','Lavar e Passar'),
('Camiseta','9.00','Lavar e Passar'),
('Camisola','9.00','Lavar e Passar'),
('Canga','7.00','Lavar e Passar'),
('Capa de Chuva (Adulto)','32.00','Lavar e Passar'),
('Casaco 7/8','38.00','Lavar e Passar'),
('Casaco com Detalhes','36.00','Lavar e Passar'),
('Casaco de Moletom','28.00','Lavar e Passar'),
('Casaco Moletom','28.00','Lavar e Passar'),
('Chambe','13.00','Lavar e Passar'),
('Colete','18.00','Lavar e Passar'),
('Jaqueta','30.00','Lavar e Passar'),
('Jardineira','16.00','Lavar e Passar'),
('Lenço Echarpe','11.00','Lavar e Passar'),
('Macação','24.00','Lavar e Passar'),
('Parka','32.00','Lavar e Passar'),
('Pijama Completo','18.00','Lavar e Passar'),
('Ponche','30.00','Lavar e Passar'),
('Quimono Complete','30.00','Lavar e Passar'),
('Role','14.00','Lavar e Passar'),
('Saia Grande','21.00','Lavar e Passar'),
('Saia Lisa','14.00','Lavar e Passar'),
('Sobretudo','40.00','Lavar e Passar'),
('Tunno','45.00','Lavar e Passar'),
('Vestido','25.00','Lavar e Passar'),
('Vestido Detalhe','75.00','Lavar e Passar'),
('Vestido Curso','25.00','Lavar e Passar');

-- *****************************************************
-- *                       ROOMS         	           *
-- *****************************************************

INSERT INTO room (number, type_room_id)
VALUES 
('01',1),
('02',2),
('03',3),
('04',4),
('05',5),
('06',6),
('07',1),
('08',2),
('09',3),
('10',4),
('11',5),
('12',6),
('13',1),
('14',4),
('15',5),
('16',6),
('17',2),
('18',3),
('19',4),
('20',5),
('21',6);

-- *****************************************************
-- *                    CONTROL TYPES        	       *
-- *****************************************************

INSERT INTO control_types (type) VALUES
('Água'),
('Alimentos/Bebidas'),
('Energia Elétrica'),
('Materiais de Escritório'),
('Material de Limpeza'),
('Telefone/Internet'),
('Manutenção');

-- *****************************************************
-- *                     TYPES PHONE        	       *
-- *****************************************************

INSERT INTO type_phone(type_phone) VALUES 
('Celular'),('Fixo'),('Fornecedor');

-- *****************************************************
-- *                   STATUS ROOM        	           *
-- *****************************************************

INSERT INTO status_room(number_room) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21);