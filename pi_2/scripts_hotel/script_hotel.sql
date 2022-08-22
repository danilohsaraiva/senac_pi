-- *****************************************************
-- *                SCRIPT FROM DB. HOTEL		       *
-- *****************************************************
CREATE DATABASE hotel;
USE hotel;
-- *****************************************************
-- *                     STORAGE   	    	       *
-- *****************************************************

CREATE TABLE control(
	id INT AUTO_INCREMENT,
    type INT NOT NULL, 
	description VARCHAR(45),
	value DECIMAL (9,2) NOT NULL,
	date DATE NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE control_types(
id INT AUTO_INCREMENT,
type VARCHAR(45) NOT NULL,
PRIMARY KEY (id)
);

-- *****************************************************
-- *                       COSTUMER         	       *
-- *****************************************************

CREATE TABLE costumer(
id INT AUTO_INCREMENT,
name VARCHAR(45),
birth_date VARCHAR(45),
rg VARCHAR(14),
ur CHAR(2),
cpf VARCHAR (45),
special_needs CHAR(1) DEFAULT 'N',
email VARCHAR (45) NOT NULL,
description VARCHAR(45),
PRIMARY KEY (id)
);

-- *****************************************************
-- *                       ROOMS         	           *
-- *****************************************************

CREATE TABLE type_room(
id INT AUTO_INCREMENT,
type VARCHAR (45),
description VARCHAR(255),
value DECIMAL(9,2),
PRIMARY KEY (id)
);

CREATE TABLE status_room(
id INT NOT NULL AUTO_INCREMENT,
number_room INT NOT NULL,
free TINYINT DEFAULT (1),
busy TINYINT DEFAULT(0),
maintenance TINYINT DEFAULT(0),
PRIMARY KEY (id)
);

CREATE TABLE room (
id INT AUTO_INCREMENT NOT NULL,
number INT NOT NULL,
type_room_id INT NOT NULL,
maintenance TINYINT DEFAULT (0),
PRIMARY KEY (id),
CONSTRAINT `fk_type_room` FOREIGN KEY (type_room_id) REFERENCES type_room(id)
);

-- *****************************************************
-- *                       SERVICES           	       *
-- *****************************************************

CREATE TABLE menu_restaurant (
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(45) NOT NULL,
value DECIMAL (9,2) NOT NULL,
type VARCHAR (45) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE laundry (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(45) NOT NULL,
value DECIMAL (9,2) NOT NULL,
description VARCHAR(45) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE service_restaurant (
menu_id INT NOT NULL,
service_order_id INT NOT NULL,
date DATETIME,
qty INT NOT NULL,
CONSTRAINT `fk_menu` FOREIGN KEY (menu_id) REFERENCES menu_restaurant (id)
);

CREATE TABLE service_laundry (
laundry_id INT NOT NULL,
service_order_id INT NOT NULL,
date DATETIME NOT NULL, 
qty INT NOT NULL,
CONSTRAINT `fk_laundry` FOREIGN KEY (laundry_id) REFERENCES laundry(id)
);

-- missing foreign key from service_restaurant and service_laundry to book_hotel, there are in row 185 and 186 ***

-- *****************************************************
-- *           COLLAB. FUNCTIONS & USER SISTEM         *
-- *****************************************************

CREATE TABLE collaborator_function (
id INT AUTO_INCREMENT NOT NULL,
function_collab VARCHAR (45) NOT NULL,
description VARCHAR (45) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE user_sistem (
id INT AUTO_INCREMENT NOT NULL,
login VARCHAR (45) NOT NULL, 
password TEXT NOT NULL,
user_id INT NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE collaborator (
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(45) NOT NULL,
cpf VARCHAR(45),
rg VARCHAR(14),
ur CHAR(2),
birth_date VARCHAR(45) NOT NULL,
email VARCHAR(45),
function_id INT,
PRIMARY KEY (id),
CONSTRAINT `fk_function` FOREIGN KEY (function_id) REFERENCES collaborator_function(id)
);

-- *****************************************************
-- *                 COSTUMER PROCESS                  *
-- *****************************************************

CREATE TABLE accommodation (
id INT AUTO_INCREMENT NOT NULL,
check_in DATETIME NOT NULL,
check_out DATETIME,
room_id INT NOT NULL, 
PRIMARY KEY (id)
);

CREATE TABLE costumer_to_accommodation (
book_hotel_id INT NOT NULL, 
accommodation_id INT,
costumer_id INT NOT NULL, 
CONSTRAINT `fk_accommodation` FOREIGN KEY (accommodation_id) REFERENCES accommodation(id),
CONSTRAINT `fk_costumer_id` FOREIGN KEY (costumer_id) REFERENCES costumer(id)
);

CREATE TABLE book_hotel (
id INT AUTO_INCREMENT NOT NULL, 
date_to_checkin DATETIME NOT NULL,
date_to_checkout DATETIME NOT NULL, 
card_number VARCHAR(45),
costumer_id INT NOT NULL,
type_room_id INT NOT NULL,
CONSTRAINT `fk_costumer` FOREIGN KEY (costumer_id) REFERENCES costumer(id),
CONSTRAINT `fk_type_room_book` FOREIGN KEY (type_room_id) REFERENCES type_room(id),
PRIMARY KEY(id)
);

ALTER TABLE costumer_to_accommodation ADD CONSTRAINT `fk_book` FOREIGN KEY (book_hotel_id) REFERENCES book_hotel(id);

ALTER TABLE service_restaurant ADD CONSTRAINT `fk_service_order_id` FOREIGN KEY (service_order_id) REFERENCES book_hotel (id);
ALTER TABLE service_laundry ADD CONSTRAINT `fk_service_order` FOREIGN KEY (service_order_id) REFERENCES book_hotel (id); 


-- *****************************************************
-- *                      PAYMENT                      *
-- *****************************************************

CREATE TABLE report_payment (
id INT AUTO_INCREMENT NOT NULL,
payment_id INT NOT NULL,
book_hotel_id INT NOT NULL,
PRIMARY KEY(id),
CONSTRAINT `fk_reference_b_h` FOREIGN KEY (book_hotel_id) REFERENCES book_hotel(id)
);

CREATE TABLE type_of_payment (
id INT AUTO_INCREMENT NOT NULL,
type VARCHAR(45) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE payment (
id INT AUTO_INCREMENT NOT NULL,
value DECIMAL (9,2) NOT NULL, 
description VARCHAR(45) NOT NULL,
date DATETIME NOT NULL,
PRIMARY KEY(id),
type_id INT NOT NULL,
CONSTRAINT `fk_type_payment` FOREIGN KEY(type_id) REFERENCES type_of_payment(id)
);

ALTER TABLE report_payment ADD CONSTRAINT `fk_payment` FOREIGN KEY (payment_id) REFERENCES payment(id);

-- *****************************************************
-- *                  ADDRESS & PHONE                  *
-- *****************************************************

CREATE TABLE address (
id INT AUTO_INCREMENT NOT NULL,
logradouro VARCHAR(45) NOT NULL,
number VARCHAR(45) NOT NULL,
district VARCHAR(45) NOT NULL,
city VARCHAR(45) NOT NULL,
cep VARCHAR(45) NOT NULL,
state VARCHAR(45) NOT NULL,
country VARCHAR(45) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE type_phone (
id INT NOT NULL AUTO_INCREMENT,
type_phone VARCHAR (45) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE phone(
id INT AUTO_INCREMENT NOT NULL,
ddi CHAR(2) NOT NULL DEFAULT '55',
ddd CHAR(2) NOT NULL,
number VARCHAR (45) NOT NULL,
type_id INT NOT NULL,
PRIMARY KEY(id),
CONSTRAINT `fk_type_phone` FOREIGN KEY (type_id) REFERENCES type_phone(id)
);

CREATE TABLE contact_costumer (
id INT AUTO_INCREMENT NOT NULL,
phone_id INT NOT NULL,
costumer_id INT NOT NULL,
PRIMARY KEY(id),
CONSTRAINT `fk_phone_id` FOREIGN KEY (phone_id) REFERENCES phone(id),
CONSTRAINT `fk_costumer_contact`	FOREIGN KEY (costumer_id) REFERENCES costumer(id)
);

CREATE TABLE contact_collaborator (
id INT AUTO_INCREMENT NOT NULL,
phone_id INT NOT NULL,
collaborator_id INT NOT NULL, 
PRIMARY KEY(id),
CONSTRAINT `fk_phone_collaborator` FOREIGN KEY (phone_id) REFERENCES phone(id),
CONSTRAINT `fk_collaborator_contact`	 FOREIGN KEY (collaborator_id) REFERENCES collaborator(id)
);

CREATE TABLE collaborator_address (
id INT AUTO_INCREMENT NOT NULL,
collaborator_id INT NOT NULL,
address_id INT NOT NULL,
PRIMARY KEY(id),
CONSTRAINT `fk_collaborator_address_id` FOREIGN KEY (collaborator_id) REFERENCES collaborator(id),
CONSTRAINT `fk_address_to_collaborator` FOREIGN KEY (address_id) REFERENCES address(id)
);

CREATE TABLE costumer_address (
id INT AUTO_INCREMENT NOT NULL,
costumer_id INT NOT NULL,
address_id INT NOT NULL,
PRIMARY KEY(id),
CONSTRAINT `fk_costumer_address` FOREIGN KEY (costumer_id) REFERENCES costumer(id),
CONSTRAINT `fk_address_to_costumer` FOREIGN KEY (address_id) REFERENCES address(id)
);