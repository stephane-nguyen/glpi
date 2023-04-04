

/****** ATTENTION ******/
/* 
Etapes à suivre avant de lancer ce script :
1. Avoir déjà lancé le script 01_db_system.sql dans un premier 
   terminal SQL*Plus connecté en tant que SYSTEM
2. Avoir déjà lancé le script @02_db_cergy.sql dans un deuxième 
    terminal SQL*Plus connecté en tant que user_cergy
3. Avoir déjà lancé le script @03_db_pau.sql dans un troisième 
    terminal SQL*Plus connecté en tant que user_pau    
4. Une fois l'étape 1 2 3 réalisée, lancer le script @04_materialized_view_cergy.sql
   dans le deuxième terminal SQL*Plus connecté en tant que user_cergy


/** ===================== CERGY MATERIALIZED VIEW ============================== **/
-- DASHBOARD is CERGY : Display all tickets from Cergy and Pau 
DROP MATERIALIZED VIEW materialized_view_tickets;
CREATE MATERIALIZED VIEW materialized_view_tickets
AS
SELECT * FROM ticket_cergy
UNION ALL
SELECT * FROM ticket_pau@database_pau_to_cergy; 

-- tester la requête
select * from materialized_view_tickets;



