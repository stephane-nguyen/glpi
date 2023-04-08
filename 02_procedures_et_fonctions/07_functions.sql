


-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;

-- à lancer dans user_cergy




/********** FUNCTIONS **********/


/****************************************************/
-- fonction qui retourne le SOFTWARE_NAME grace à l'id du Software.
CREATE OR REPLACE FUNCTION get_SoftwareName_by_SoftwareId(p_SoftwareId IN NUMBER)
RETURN VARCHAR2
AS
   v_name VARCHAR2(20);
BEGIN
   SELECT name INTO v_name FROM software WHERE id = p_SoftwareId;
   RETURN v_name;    
END;
/ 

--TEST
DECLARE
   result VARCHAR2(15);
BEGIN
   result := get_SoftwareName_by_SoftwareId(4001);
   DBMS_OUTPUT.PUT_LINE('Le software numéro ''4001'' est : ' || result);
END;
/
/****************************************************/






/****************************************************/
-- fonction qui retourne le SOFTWARE_NAME grace à l'id du Software.
CREATE OR REPLACE FUNCTION get_DeviceId_by_DeviceName(p_DeviceName VARCHAR2)
RETURN NUMBER
AS
   v_DeviceId VARCHAR2(20);
BEGIN
   SELECT id INTO v_DeviceId FROM computer_device_cergy WHERE name = p_DeviceName;
   RETURN v_DeviceId;    
END;
/ 

--TEST
DECLARE
   result NUMBER;
BEGIN
   result := get_DeviceId_by_DeviceName('clavier');
   DBMS_OUTPUT.PUT_LINE('Le device nommé ''clavier'' a l''ID suivant : ' || result);
END;
/
/****************************************************/






/****************************************************/
CREATE OR REPLACE FUNCTION sum_of_squares (start_num IN NUMBER, end_num IN NUMBER)
RETURN NUMBER
IS
   total_sum NUMBER := 0;
BEGIN
   FOR i IN start_num..end_num LOOP
      total_sum := total_sum + (i * i);
   END LOOP;
   
   RETURN total_sum;
END;
/

DECLARE
   result NUMBER;
BEGIN
   result := sum_of_squares(1, 5);
   DBMS_OUTPUT.PUT_LINE('La somme des carrés des nombres entre 1 et 5 est : ' || result);
END;
/
/****************************************************/











