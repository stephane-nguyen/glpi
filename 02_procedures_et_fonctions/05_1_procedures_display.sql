
/****** ATTENTION ******/
/* 
Etapes à suivre avant de lancer ce script :
1. Avoir déjà lancé le script 01_db_system.sql dans un premier 
   terminal SQL*Plus connecté en tant que SYSTEM
2. Avoir déjà lancé le script @02_db_cergy.sql dans un deuxième 
    terminal SQL*Plus connecté en tant que user_cergy
3. Avoir déjà lancé le script @03_db_pau.sql dans un troisième 
    terminal SQL*Plus connecté en tant que user_pau    
4. Avoir déjà lancé le script @04_materialized_view_cergy.sql
   dans le deuxième terminal SQL*Plus connecté en tant que user_cergy
5. Une fois l'étape 1 2 3 4 réalisée,
    vous restez dans le deuxième terminal SQL*Plus connecté en tant que user_cergy.
    Vous pouvez lancer les procédures de ce fichier,
    MAIS PAS TOUTES A LA FOIS, seulement une par une.
   
*/

/** ************************* PROCEDURES ************************* **/

-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;


/****************************************************************************************/
-- PROCEDURE CURSEUR / BOUCLE FOR : afficher les tickets de Cergy et de Pau
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE afficher_tickets_cergy_et_pau IS
BEGIN
   FOR cur IN (SELECT * FROM materialized_view_tickets) LOOP
      DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || cur.id || ', Description: ' || cur.description || ', Ville: ' || cur.ville);
   END LOOP;
END;
/
EXECUTE afficher_tickets_cergy_et_pau;
/****************************************************************************************/



/****************************************************************************************/
-- PROCEDURE CURSEUR/FETCH : afficher les tickets de Cergy et de Pau
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE afficher_tickets_cergy_et_pau IS
    CURSOR curseur IS SELECT id, description, ville, ticket_date FROM materialized_view_tickets;
    v_id NUMBER;    
    v_description VARCHAR2(100);
    v_ville VARCHAR2(100);
    v_date DATE;
    
    CURSOR curseur_cergy IS SELECT id, firstname, lastname FROM user_cergy;
    v_id_cergy user_cergy.id%TYPE;
    v_first_name_cergy user_cergy.firstname%TYPE;
    v_last_name_cergy user_cergy.lastname%TYPE;

    CURSOR curseur_pau IS SELECT id, firstname, lastname FROM user_pau@database_pau_to_cergy;
    v_id_pau NUMBER;
    v_first_name_pau VARCHAR2(100);
    v_last_name_pau VARCHAR2(100);

BEGIN
    OPEN curseur;
    OPEN curseur_cergy;
    OPEN curseur_pau;

    LOOP
        FETCH curseur INTO v_id, v_description, v_ville, v_date;
        EXIT WHEN curseur%NOTFOUND;
 
        DBMS_OUTPUT.PUT('Ticket ID: ' || v_id || CHR(9));

        IF v_ville = 'CERGY' THEN 
            FETCH curseur_cergy INTO v_id_cergy, v_first_name_cergy, v_last_name_cergy;    
            DBMS_OUTPUT.PUT(', First Name : '  || v_first_name_cergy || CHR(9) || ', Last Name : ' || v_last_name_cergy || CHR(9));
        END IF;
        IF v_ville = 'PAU' THEN 
            FETCH curseur_pau INTO v_id_pau, v_first_name_pau, v_last_name_pau;    
            DBMS_OUTPUT.PUT(', First Name : '  || v_first_name_pau || CHR(9) || ', Last Name : ' || v_last_name_pau || CHR(9));
        END IF;        

        DBMS_OUTPUT.PUT_LINE(', Description: ' || v_description || CHR(9) || ', Ville: ' || v_ville || CHR(9) || ', Date: ' || v_date);

    END LOOP;

    -- AUTRES FACONS DE FAIRE : WHILE / FOR
    -- while curseur%FOUND LOOP
    --     FETCH curseur INTO v_id, v_description, v_ville;
    -- end loop;

    -- FOR cur IN (SELECT * FROM materialized_view_tickets) LOOP
    --     DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || cur.id || ', Description: ' || cur.description || ', Ville: ' || cur.ville);
    -- END LOOP;
END;
/
EXECUTE afficher_tickets_cergy_et_pau;
/****************************************************************************************/



/****************************************************************************************/
-- PROCEDURE : afficher un compteur qui augmente en fonction du nombre de ligne de tickets
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE afficher_tickets_cergy_et_pau IS
    i NUMBER;
    v_count NUMBER;
BEGIN
    select (count(*)) into v_count from materialized_view_tickets;
    FOR i in 1..v_count LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/
EXECUTE afficher_tickets_cergy_et_pau;
/****************************************************************************************/



   
/****************************************************************************************/
-- PROCEDURE : afficher les user de Cergy 
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE afficher_users_cergy IS
BEGIN
   FOR cur IN (SELECT * FROM user_cergy) LOOP
      DBMS_OUTPUT.PUT_LINE(cur.id || CHR(9) || ' ' || cur.firstname || CHR(9) || ' ' || cur.lastname || CHR(9) || ' ' || cur.email);
   END LOOP;
END;
/
EXECUTE afficher_users_cergy;
/****************************************************************************************/




/****************************************************************************************/
-- PROCEDURE : afficher le prénom de l'utilisateur de Cergy qui a l'id 1001
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE afficher_user_cergy_1001 IS
-- DECLARE
   v_first_name user_cergy.firstname%TYPE;
BEGIN
   SELECT firstname INTO v_first_name FROM user_cergy WHERE id = 1001;
   DBMS_OUTPUT.PUT_LINE('Le prénom de l''utilisateur 1001 est : ' || v_first_name);
END;
/
EXECUTE afficher_user_cergy_1001;
/****************************************************************************************/





commit;

