/****** ATTENTION ******/
/* 
Etapes à suivre avant de lancer ce script :
1. Avoir déjà lancé le script 01_db_system.sql dans un premier 
    terminal SQL*Plus connecté en tant que SYSTEM
2. Ouvrir une deuxième fenêtre SQL*Plus, et se connecter en tant que user_cergy
3. Dans la deuxième fenêtre SQL*Plus, lancer le script suivant : @02_db_cergy.sql
*/

drop database link database_pau_to_cergy;
create database link database_pau_to_cergy connect to user_pau identified by user_pau using 'XE';

-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;


/** ===================== TABLE CREATION ============================== **/

-- CERGY INFRASTRUCTURE
--Creation d'un cluster user/ticket/computer
DROP TABLE ticket_cergy CASCADE CONSTRAINTS;
DROP TABLE computer_cergy CASCADE CONSTRAINTS;
DROP CLUSTER my_cluster;
CREATE CLUSTER my_cluster 
(user_id NUMBER)
SIZE 1024
TABLESPACE users;

-- Creation des tables
DROP TABLE admin CASCADE CONSTRAINTS;
CREATE TABLE admin (
    id NUMBER NOT NULL PRIMARY KEY,
    firstname VARCHAR2(15) NOT NULL,
    lastname VARCHAR2(15) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    inventory NUMBER NOT NULL
);

DROP TABLE inventory CASCADE CONSTRAINTS;
CREATE TABLE inventory (
    id NUMBER NOT NULL PRIMARY KEY,
    software_quantity NUMBER NOT NULL,
    computer_quantity NUMBER NOT NULL,
    computer_device_quantity NUMBER NOT NULL
);

DROP TABLE user_cergy CASCADE CONSTRAINTS;
CREATE TABLE user_cergy (
    id NUMBER NOT NULL PRIMARY KEY,
    firstname VARCHAR2(15) NOT NULL,
    lastname VARCHAR2(15) NOT NULL, 
    email VARCHAR2(30) NOT NULL
);

-- Si le ticket ne concerne que l'ordinateur et pas les softwares ou les devices
-- alors on autorise les valeurs NULL pour les colonnes software_id et computer_device_id
DROP TABLE ticket_cergy CASCADE CONSTRAINTS;
CREATE TABLE ticket_cergy (
    id NUMBER NOT NULL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    computer_id NUMBER,
    computer_device_id NUMBER,
    software_id NUMBER,
    ticket_date DATE NOT NULL, 
    description VARCHAR(30) NOT NULL,
    city VARCHAR(10) NOT NULL
)CLUSTER my_cluster (user_id);

DROP TABLE computer_cergy CASCADE CONSTRAINTS;
CREATE TABLE computer_cergy (
    id NUMBER NOT NULL PRIMARY KEY,
    computer_device_id NUMBER,
    software_id NUMBER,
    user_id NUMBER
)CLUSTER my_cluster(user_id);

DROP TABLE computer_device_cergy CASCADE CONSTRAINTS;
CREATE TABLE computer_device_cergy (
    id NUMBER NOT NULL PRIMARY KEY,
    name VARCHAR2(10) NOT NULL
);

DROP TABLE software CASCADE CONSTRAINTS;
CREATE TABLE software (
    id NUMBER NOT NULL PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);


-- création de l'index CLUSTER
CREATE INDEX idx_my_cluster ON CLUSTER my_cluster;


ALTER TABLE admin ADD CONSTRAINT fk_inventory FOREIGN KEY (inventory) REFERENCES inventory (id);

ALTER TABLE ticket_cergy ADD CONSTRAINT fk_ticket_user_id FOREIGN KEY (user_id) REFERENCES user_cergy (id);
ALTER TABLE ticket_cergy ADD CONSTRAINT fk_ticket_computer_device_id FOREIGN KEY (computer_device_id) REFERENCES computer_device_cergy (id);
ALTER TABLE ticket_cergy ADD CONSTRAINT fk_ticket_software_id FOREIGN KEY (software_id) REFERENCES software (id);
ALTER TABLE ticket_cergy ADD CONSTRAINT fk_ticket_computer_id FOREIGN KEY (computer_id) REFERENCES computer_cergy (id);

ALTER TABLE computer_cergy ADD CONSTRAINT fk_computer_user_id FOREIGN KEY (user_id) REFERENCES user_cergy (id);
ALTER TABLE computer_cergy ADD CONSTRAINT fk_computer_computer_device_id FOREIGN KEY (computer_device_id) REFERENCES computer_device_cergy (id);
ALTER TABLE computer_cergy ADD CONSTRAINT fk_computer_software_id FOREIGN KEY (software_id) REFERENCES software (id);

/** ======== INSERTIONS DE DONNEES CERGY ========= **/

-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;

-- Users Cergy
DELETE FROM user_cergy;
INSERT INTO user_cergy (id, firstname, lastname, email) VALUES (1001, 'Jean', 'Dupont', 'jean.dupont@cergy.fr');
INSERT INTO user_cergy (id, firstname, lastname, email) VALUES (1002, 'Marie', 'Martin', 'marie.martin@cergy.fr');
INSERT INTO user_cergy (id, firstname, lastname, email) VALUES (1003, 'Luc', 'Dubois', 'luc.dubois@cergy.fr');
INSERT INTO user_cergy (id, firstname, lastname, email) VALUES (1004, 'Sophie', 'Lecomte', 'sophie.lecomte@cergy.fr');
INSERT INTO user_cergy (id, firstname, lastname, email) VALUES (1005, 'Pierre', 'Morel', 'pierre.morel@cergy.fr');


-- Computer Device Cergy
DELETE FROM computer_device_cergy;
INSERT INTO computer_device_cergy (id, name) VALUES (3001, 'souris');
INSERT INTO computer_device_cergy (id, name) VALUES (3002, 'clavier');
INSERT INTO computer_device_cergy (id, name) VALUES (3003, 'écran');
INSERT INTO computer_device_cergy (id, name) VALUES (3004, 'cable');
INSERT INTO computer_device_cergy (id, name) VALUES (3005, 'imprimante');

-- Software
DELETE FROM software;
INSERT INTO software (id, name) VALUES (4001, 'Windows');
INSERT INTO software (id, name) VALUES (4002, 'Ubuntu');
INSERT INTO software (id, name) VALUES (4003, 'Office');
INSERT INTO software (id, name) VALUES (4004, 'Adobe');
INSERT INTO software (id, name) VALUES (4005, 'Antivirus');

-- Computer Cergy
DELETE FROM computer_cergy;
INSERT INTO computer_cergy (id, computer_device_id, software_id, user_id) VALUES (2001, 3001, 4001, 1001);
INSERT INTO computer_cergy (id, computer_device_id, software_id, user_id) VALUES (2002, 3002, 4002, 1002);
INSERT INTO computer_cergy (id, computer_device_id, software_id, user_id) VALUES (2003, 3003, 4003, 1003);
INSERT INTO computer_cergy (id, computer_device_id, software_id, user_id) VALUES (2004, 3004, 4004, 1004);
INSERT INTO computer_cergy (id, computer_device_id, software_id, user_id) VALUES (2005, 3005, 4005, 1005);

-- Inventory
DELETE FROM inventory;
INSERT INTO inventory (id, software_quantity, computer_quantity, computer_device_quantity) VALUES (1001, 100, 50, 70);

-- Admin
DELETE FROM admin;
INSERT INTO admin (id, firstname, lastname, email, inventory) VALUES (1001, 'VoKy', 'TRUONG', 'voky@cergy.fr', 1001);

-- Ticket Cergy
DELETE FROM ticket_cergy;
INSERT INTO ticket_cergy (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5001, 1001, NULL, 3001, NULL, TO_DATE('2023-03-31 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'souris ne marche pas', 'CERGY');
INSERT INTO ticket_cergy (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5002, 1002, NULL, 3002, NULL, TO_DATE('2023-03-31 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'clavier ne marche pas', 'CERGY');
INSERT INTO ticket_cergy (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5003, 1003, NULL, 3001, NULL, TO_DATE('2023-03-31 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'souris ne marche pas', 'CERGY');
INSERT INTO ticket_cergy (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5004, 1004, NULL, NULL, 4003, TO_DATE('2023-04-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'besoin du logiciel office', 'CERGY');
INSERT INTO ticket_cergy (id, user_id, computer_id, computer_device_id, software_id, ticket_date, description, city) VALUES (5005, 1005, 2005, NULL, NULL, TO_DATE('2023-04-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'ordinateur en panne', 'CERGY');

-- Affichage des tickets
select * from ticket_cergy;

commit;
