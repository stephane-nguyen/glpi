
 /* removing c## obligation */
alter session set "_ORACLE_SCRIPT"=true;

/** ===================== USERS AND TABLESPACES CREATION ============================== **/
CREATE USER user_cergy IDENTIFIED BY user_cergy;
CREATE USER user_pau IDENTIFIED BY user_pau;
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE DATABASE LINK TO user_cergy;
GRANT CONNECT, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE DATABASE LINK TO user_pau;

/** ===================== TABLESPACE LINK CREATION ============================== **/
-- Link cergy to pau from Pau database
drop database link database_cergy_to_pau;
create database link database_cergy_to_pau connect to user_cergy identified by user_cergy using 'XE';

drop database link database_pau_to_cergy;
create database link database_pau_to_cergy connect to user_pau identified by user_pau using 'XE';


-- You have to connect on the correct site to create tables and views

/** ===================== ORDRE DE LANCEMENT DES SCRIPTS SQL ============================== **/
/* 
01_db_system.sql
02_db_cergy.sql
03_db_pau.sql
04_materialized_view_cergy.sql
*/

/* unlimited quota on tablespace */ 
ALTER USER user_cergy quota unlimited on USERS;
ALTER USER user_pau quota unlimited on USERS;


commit;
