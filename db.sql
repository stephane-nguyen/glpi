-- first version database to dev PL SQL --


/** ===================== USERS AND TABLESPACES CREATION ============================== **/
CREATE USER user_cergy IDENTIFIED BY user_cergy;
CREATE USER user_pau IDENTIFIED BY user_pau;
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE DATABASE LINK TO user_pau;
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE DATABASE LINK TO user_cergy;


/** ===================== TABLE CREATION ============================== **/
-- CERGY INFRASTRUCTURE
DROP TABLE ADMIN CASCADE CONSTRAINTS;
CREATE TABLE ADMIN (
    ADMIN_ID NUMBER NOT NULL PRIMARY KEY,
    FIRSTNAME VARCHAR2(30) NOT NULL,
    LASTNAME VARCHAR2(30) NOT NULL,
    ADMIN_EMAIL VARCHAR2(55) NOT NULL,
    INVENTORY NUMBER NOT NULL,
    CONSTRAINT fk_inventory FOREIGN KEY (INVENTORY) REFERENCES INVENTORY (INVENTORY_ID)
);

DROP TABLE INVENTORY CASCADE CONSTRAINTS;
CREATE TABLE INVENTORY (
    INVENTORY_ID NUMBER NOT NULL PRIMARY KEY,
    SOFTWARE_QUANTITY NUMBER NOT NULL,
    COMPUTER_QUANTITY NUMBER NOT NULL,
    DEVICE_QUANTITY NUMBER NOT NULL
);

DROP TABLE USERS CASCADE CONSTRAINTS;
CREATE TABLE USERS (
    USER_ID NUMBER NOT NULL PRIMARY KEY,
    FIRSTNAME VARCHAR2(100) NOT NULL,
    LASTNAME VARCHAR2(100) NOT NULL, 
    USER_ROLE VARCHAR2(100) NOT NULL,
    USER_EMAIL VARCHAR2(100) NOT NULL
);

DROP TABLE TICKET CASCADE CONSTRAINTS;
CREATE TABLE TICKET (
    TICKET_ID NUMBER NOT NULL PRIMARY KEY,
    USER_ID NUMBER NOT NULL,
    COMPUTER_DEVICE_ID NUMBER NOT NULL,
    SOFTWARE_ID NUMBER NOT NULL,
    COMPUTER_ID NUMBER NOT NULL,
    TICKET_DATE DATE NOT NULL,
    DESCRIPTION VARCHAR2(1000) NOT NULL,
    CONSTRAINT fk_user_id FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
    CONSTRAINT fk_computer_device_id FOREIGN KEY (COMPUTER_DEVICE_ID) REFERENCES COMPUTER_DEVICE (COMPUTER_DEVICE_ID),
    CONSTRAINT fk_software_id FOREIGN KEY (SOFTWARE_ID) REFERENCES SOFTWARE (SOFTWARE_ID),
    CONSTRAINT fk_computer_id FOREIGN KEY (COMPUTER_ID) REFERENCES COMPUTER (COMPUTER_ID)
);

DROP TABLE COMPUTER CASCADE CONSTRAINTS;
CREATE TABLE COMPUTER (
    COMPUTER_ID NUMBER NOT NULL PRIMARY KEY,
    COMPUTER_DEVICE_ID NUMBER NOT NULL,
    SOFTWARE_ID NUMBER NOT NULL,
    USER_ID NUMBER NOT NULL,
    QUANTITY NUMBER NOT NULL,
    CONSTRAINT fk_software_id FOREIGN KEY (SOFTWARE_ID) REFERENCES SOFTWARE (SOFTWARE_ID),
    CONSTRAINT fk_user_id FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
    CONSTRAINT fk_computer_device_id FOREIGN KEY (COMPUTER_DEVICE_ID) REFERENCES COMPUTER_DEVICE (COMPUTER_DEVICE_ID)
);

DROP TABLE COMPUTER_DEVICE CASCADE CONSTRAINTS;
CREATE TABLE COMPUTER_DEVICE (
    COMPUTER_DEVICE_ID NUMBER NOT NULL PRIMARY KEY,
    COMPUTER_ID NUMBER NOT NULL,
    COMPUTER_DEVICE_NAME VARCHAR2(50) NOT NULL,
    COMPUTER_DEVICE_TYPE VARCHAR2(50) NOT NULL,
    COMPUTER_DEVICE_DESCRIPTION VARCHAR2(1000) NOT NULL,
    COMPUTER_DEVICE_QUANTITY NUMBER NOT NULL,
    CONSTRAINT fk_computer_id FOREIGN KEY (COMPUTER_ID) REFERENCES COMPUTER (COMPUTER_ID)
);

DROP TABLE SOFTWARE CASCADE CONSTRAINTS;
CREATE TABLE SOFTWARE (
    SOFTWARE_ID NUMBER NOT NULL PRIMARY KEY,
    SOFTWARE_NAME VARCHAR2(50) NOT NULL,
    SOFTWARE_DESCRIPTION VARCHAR2(1000) NOT NULL,
    SOFTWARE_QUANTITY NUMBER NOT NULL
);

-- PAU INFRASTRUCTURE
DROP TABLE USERS CASCADE CONSTRAINTS;
CREATE TABLE USERS (
    USER_ID NUMBER NOT NULL PRIMARY KEY,
    FIRSTNAME VARCHAR2(100) NOT -NULL,
    LASTNAME VARCHAR2(100) NOT NULL,
    USER_EMAIL VARCHAR2(100) NOT NULL,
    USER_ROLE VARCHAR2(100) NOT NULL
);

DROP TABLE TICKET CASCADE CONSTRAINTS;
CREATE TABLE TICKET (
    TICKET_ID NUMBER NOT NULL PRIMARY KEY,
    USER_ID NUMBER NOT NULL,
    COMPUTER_DEVICE_ID NUMBER NOT NULL,
    SOFTWARE_ID NUMBER NOT NULL,
    COMPUTER_ID NUMBER NOT NULL,
    TICKET_DATE DATE NOT NULL,
    DESCRIPTION VARCHAR2(1000) NOT NULL,
    CONSTRAINT fk_user_id FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
    CONSTRAINT fk_computer_device_id FOREIGN KEY (COMPUTER_DEVICE_ID) REFERENCES COMPUTER_DEVICE (COMPUTER_DEVICE_ID),
    -- Clé étrangère vers SOFTWARE, sauf que pau à une vue des softwares de cergy
    -- CONSTRAINT fk_software_id FOREIGN KEY (SOFTWARE_ID) REFERENCES SOFTWARE (SOFTWARE_ID),
    CONSTRAINT fk_computer_id FOREIGN KEY (COMPUTER_ID) REFERENCES COMPUTER (COMPUTER_ID)
);

DROP TABLE COMPUTER CASCADE CONSTRAINTS;
CREATE TABLE COMPUTER (
    COMPUTER_ID NUMBER NOT NULL PRIMARY KEY,
    COMPUTER_DEVICE_ID NUMBER NOT NULL,
    SOFTWARE_ID NUMBER NOT NULL,
    USER_ID NUMBER NOT NULL,
    QUANTITY NUMBER NOT NULL,
    -- Clé étrangère vers SOFTWARE, sauf que pau à une vue des softwares de cergy
    -- CONSTRAINT fk_software_id FOREIGN KEY (SOFTWARE_ID) REFERENCES SOFTWARE (SOFTWARE_ID),
    CONSTRAINT fk_user_id FOREIGN KEY (USER_ID) REFERENCES USERS (USER_ID),
    CONSTRAINT fk_computer_device_id FOREIGN KEY (COMPUTER_DEVICE_ID) REFERENCES COMPUTER_DEVICE (COMPUTER_DEVICE_ID)
);

DROP TABLE COMPUTER_DEVICE CASCADE CONSTRAINTS;
CREATE TABLE COMPUTER_DEVICE (
    COMPUTER_DEVICE_ID NUMBER NOT NULL PRIMARY KEY,
    COMPUTER_ID NUMBER NOT NULL,
    COMPUTER_DEVICE_NAME VARCHAR2(50) NOT NULL,
    COMPUTER_DEVICE_TYPE VARCHAR2(50) NOT NULL,
    COMPUTER_DEVICE_DESCRIPTION VARCHAR2(1000) NOT NULL,
    COMPUTER_DEVICE_QUANTITY NUMBER NOT NULL,
    CONSTRAINT fk_computer_id FOREIGN KEY (COMPUTER_ID) REFERENCES COMPUTER (COMPUTER_ID)
);


/** ===================== TABLESPACE LINK CREATION ============================== **/
drop database link cergy_to_pau;
create database link cergy_to_pau connect to user_pau identified by user_pau using 'XE';

-- Materialized view on software cergy
CREATE MATERIALIZED VIEW SOFTWARE_CERGY AS
 SELECT * FROM SOFTWARE@CERGY_TO_PAU;
 
-- Materialized view on inventory cergy
CREATE MATERIALIZED VIEW INVENTORY_CERGY AS
 SELECT * FROM INVENTORY@CERGY_TO_PAU;