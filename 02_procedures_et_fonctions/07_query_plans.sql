



-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;

-- à lancer dans user_cergy


-- ####################### QUERY PLANS #######################


EXPLAIN PLAN FOR 
SELECT COUNT(*) FROM user_cergy;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);



EXPLAIN PLAN FOR 
SELECT COUNT(*) FROM ticket_cergy;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);



EXPLAIN PLAN FOR 
SELECT firstname, lastname
FROM user_cergy
WHERE id = 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




-- EXPLAIN PLAN FOR 
-- SELECT name FROM software;
-- SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); -- display in readable format 


