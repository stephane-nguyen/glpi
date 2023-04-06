

/****** ATTENTION ******/
/* 
Etapes à suivre avant de lancer ce script :
1. Avoir déjà lancé le script 01_db_system.sql dans un premier 
    terminal SQL*Plus connecté en tant que SYSTEM
2. Avoir déjà lancé le script @02_db_cergy.sql dans un deuxième 
    terminal SQL*Plus connecté en tant que user_cergy    
3. Ouvrir une troisième fenêtre SQL*Plus, et se connecter en tant que user_pau
4. Dans la troisième fenêtre SQL*Plus, lancer le script suivant : @03_db_pau.sql
*/
drop database link database_cergy_to_pau;
create database link database_cergy_to_pau connect to user_cergy identified by user_cergy using 'XE';

-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;


/** ===================== PAU INFRASTRUCTURE ============================== **/

DROP TABLE user_pau CASCADE CONSTRAINTS;
CREATE TABLE user_pau (
    id NUMBER NOT NULL PRIMARY KEY,
    firstname VARCHAR2(15) NOT NULL,
    lastname VARCHAR2(15) NOT NULL, 
    email VARCHAR2(30) NOT NULL
);

DROP TABLE ticket_pau CASCADE CONSTRAINTS;
CREATE TABLE ticket_pau (
    id NUMBER NOT NULL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    computer_id NUMBER,
    computer_device_id NUMBER,
    software_id NUMBER,
    ticket_date DATE NOT NULL, 
    description VARCHAR(30),
    city VARCHAR(10) NOT NULL
);

DROP TABLE computer_pau CASCADE CONSTRAINTS;
CREATE TABLE computer_pau (
    id NUMBER NOT NULL PRIMARY KEY,
    computer_device_id NUMBER,
    software_id NUMBER,
    user_id NUMBER
);

DROP TABLE computer_device_pau CASCADE CONSTRAINTS;
CREATE TABLE computer_device_pau (
    id NUMBER NOT NULL PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);

ALTER TABLE ticket_pau ADD CONSTRAINT fk_ticket_user_id FOREIGN KEY (user_id) REFERENCES user_pau (id);
ALTER TABLE ticket_pau ADD CONSTRAINT fk_ticket_computer_device_id FOREIGN KEY (computer_device_id) REFERENCES computer_device_pau (id);
ALTER TABLE ticket_pau ADD CONSTRAINT fk_ticket_computer_id FOREIGN KEY (computer_id) REFERENCES computer_pau (id);

ALTER TABLE computer_pau ADD CONSTRAINT fk_computer_user_id FOREIGN KEY (user_id) REFERENCES user_pau (id);
ALTER TABLE computer_pau ADD CONSTRAINT fk_computer_computer_device_id FOREIGN KEY (computer_device_id) REFERENCES computer_device_pau (id);



/** ===================== PAU MATERIALIZED VIEW ============================== **/
-- Materialized view from software cergy
DROP MATERIALIZED VIEW materialized_view_software;
CREATE MATERIALIZED VIEW materialized_view_software AS
SELECT * FROM software@database_cergy_to_pau;
 
-- Materialized view from inventory cergy
DROP MATERIALIZED VIEW materialized_view_inventory;
CREATE MATERIALIZED VIEW materialized_view_inventory AS
SELECT * FROM inventory@database_cergy_to_pau;
 
-- Materialized view from admin cergy
DROP MATERIALIZED VIEW materialized_view_admin;
CREATE MATERIALIZED VIEW materialized_view_admin AS
SELECT * FROM admin@database_cergy_to_pau;


-- tester la requête
select * from materialized_view_software;
select * from materialized_view_inventory;
select * from materialized_view_admin;


/** ======== INSERTIONS DE DONNEES PAU ========= **/


-- Users Pau
DELETE FROM user_pau;
INSERT INTO user_pau (id, firstname, lastname, email) VALUES (1001, 'John', 'Doe', 'john.doe@pau.com');
INSERT INTO user_pau (id, firstname, lastname, email) VALUES (1002, 'Jane', 'Doe', 'jane.doe@pau.com');
INSERT INTO user_pau (id, firstname, lastname, email) VALUES (1003, 'Bob', 'Smith', 'bob.smith@pau.com');
INSERT INTO user_pau (id, firstname, lastname, email) VALUES (1004, 'Alice', 'Johnson', 'alice.johnson@pau.com');
INSERT INTO user_pau (id, firstname, lastname, email) VALUES (1005, 'David', 'Lee', 'david.lee@pau.com');

-- Computer Device Pau
DELETE FROM computer_device_pau;
INSERT INTO computer_device_pau (id, name) VALUES (3001, 'souris');
INSERT INTO computer_device_pau (id, name) VALUES (3002, 'clavier');
INSERT INTO computer_device_pau (id, name) VALUES (3003, 'écran');
INSERT INTO computer_device_pau (id, name) VALUES (3004, 'cable réseau');
INSERT INTO computer_device_pau (id, name) VALUES (3005, 'imprimante');

-- Computer Pau
DELETE FROM computer_pau;
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2001, 3001, 4001, 1001);
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2002, 3002, 4002, 1002);
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2003, 3003, 4003, 1003);
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2004, 3004, 4004, 1004);
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2005, 3005, 4005, 1005);

-- Ticket Pau
DELETE FROM ticket_pau;
INSERT INTO ticket_pau (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5001, 1001, NULL, 3005, NULL, TO_DATE('2023-03-31 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'imprimante ne marche pas', 'PAU');
INSERT INTO ticket_pau (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5002, 1002, NULL, 3004, NULL, TO_DATE('2023-03-31 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'cable réseau ne marche pas', 'PAU');
INSERT INTO ticket_pau (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5003, 1003, 2003, NULL, NULL, TO_DATE('2023-03-31 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ordinateur ne marche pas', 'PAU');
INSERT INTO ticket_pau (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5004, 1004, NULL, NULL, 4003, TO_DATE('2023-04-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'besoin du logiciel office', 'PAU');
INSERT INTO ticket_pau (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5005, 1005, NULL, NULL, 4004, TO_DATE('2023-04-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'besoin du logiciel adobe', 'PAU');

-- affichage des tickets
select * from ticket_pau;






/** ===================== PAU TRIGGER ============================== **/

/*****************************************************************************/
DROP TRIGGER computer_device_inventory;
CREATE OR REPLACE TRIGGER computer_device_inventory
AFTER INSERT OR DELETE ON computer_device_pau
FOR EACH ROW
BEGIN
    IF inserting THEN
    UPDATE inventory SET computer_device_quantity = computer_device_quantity + 1;
  ELSE
    UPDATE inventory SET computer_device_quantity = computer_device_quantity - 1;
  END IF;

  -- IF inventory.computer_device_quantity < 0 THEN
  --     UPDATE inventory SET computer_device_quantity = 0;
  --     RAISE_APPLICATION_ERROR(-20001, 'Computer device is out of stock!');
  -- END IF;

END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_device_inventory;


-- Commandes pour tester le trigger
select * from inventory;
delete from computer_device_pau where id = 3050;
INSERT INTO computer_device_pau (id, name) VALUES (3050, 'projecteur');
select * from inventory;
delete from computer_device_pau where id = 3050;
/*****************************************************************************/



/*****************************************************************************/
DROP TRIGGER computer_inventory_trigger;
CREATE OR REPLACE TRIGGER computer_inventory_trigger
AFTER INSERT OR DELETE ON computer_pau
FOR EACH ROW

BEGIN
  IF inserting THEN
    UPDATE inventory SET computer_quantity = computer_quantity + 1;
  ELSE
    UPDATE inventory SET computer_quantity = computer_quantity - 1;    
    -- IF computer_quantity <= 0 THEN
    --     UPDATE inventory SET computer_quantity = 0;
    --     RAISE_APPLICATION_ERROR(-20001, 'Computer is out of stock!');
    -- END IF;
  END IF;
END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_inventory_trigger;

-- Commandes pour tester le trigger
select * from inventory;
delete from computer_pau where id = 2050;
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2050, 3001, 4001, 1001);
select * from inventory;
delete from computer_pau where id = 2050;

/*****************************************************************************/




commit;

