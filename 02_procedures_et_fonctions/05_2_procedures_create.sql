
/** ************************* PROCEDURES ************************* **/

-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;



-- Créer une procédure qui permet de créer un ticket avec un seul des trois champs suivants : computer_id, computer_device_id, software_id
CREATE OR REPLACE PROCEDURE create_ticket_unique_problem(
  p_id IN ticket_cergy.id%TYPE,
  p_user_id IN ticket_cergy.user_id%TYPE,
  p_description IN ticket_cergy.description%TYPE,
  p_ticket_date IN ticket_cergy.ticket_date%TYPE,
  p_computer_id IN ticket_cergy.computer_id%TYPE,
  p_computer_device_id IN ticket_cergy.computer_device_id%TYPE,
  p_software_id IN ticket_cergy.software_id%TYPE,
  p_city IN ticket_cergy.city%TYPE
) AS
  v_foreign_key_count NUMBER;
BEGIN
  -- Check if multiple foreign keys are specified
  IF p_computer_id IS NOT NULL THEN
    v_foreign_key_count := v_foreign_key_count + 1;
  END IF;
  IF p_computer_device_id IS NOT NULL THEN
    v_foreign_key_count := v_foreign_key_count + 1;
  END IF;
  IF p_software_id IS NOT NULL THEN
    v_foreign_key_count := v_foreign_key_count + 1;
  END IF;   
  IF v_foreign_key_count > 1 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Cannot specify more than one foreign key');
  END IF;
   
  INSERT INTO ticket_cergy (id, user_id, description, ticket_date, computer_id, computer_device_id, software_id, city)
  VALUES (p_id, p_user_id, p_description, p_ticket_date, p_computer_id, p_computer_device_id, p_software_id, p_city);
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Ticket created successfully');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN 
      DBMS_OUTPUT.PUT_LINE('A ticket with the id has already been created');
      DBMS_OUTPUT.PUT_LINE('Solution : enter a different p_ticket_id');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE( 'Error Message ' || SQLERRM);
END;
/




/****************************************************************************************/
-- PROCEDURE : CREATION TICKET
CREATE OR REPLACE PROCEDURE create_ticket(   
   p_id IN ticket_cergy.id%TYPE,
   p_user_id IN ticket_cergy.user_id%TYPE,
   p_description IN ticket_cergy.description%TYPE,
   p_ticket_date IN ticket_cergy.ticket_date%TYPE,
   p_computer_id IN ticket_cergy.computer_id%TYPE,
   p_computer_device_id IN ticket_cergy.computer_device_id%TYPE,
   p_software_id IN ticket_cergy.software_id%TYPE,
   p_city IN ticket_cergy.city%TYPE
) AS
BEGIN
   INSERT INTO ticket_cergy(id, user_id, description, ticket_date, computer_id, computer_device_id, software_id, city)
   VALUES(p_id, p_user_id, p_description, p_ticket_date, p_computer_id, p_computer_device_id, p_software_id, p_city);
   
   COMMIT;    
   DBMS_OUTPUT.PUT_LINE('Ticket created successfully');

EXCEPTION
   WHEN DUP_VAL_ON_INDEX THEN 
      DBMS_OUTPUT.PUT_LINE('A ticket with the id has already been created');
      DBMS_OUTPUT.PUT_LINE('Solution : enter a different p_ticket_id');
    WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error creating ticket: ' || SQLERRM);
END;
/


commit;
