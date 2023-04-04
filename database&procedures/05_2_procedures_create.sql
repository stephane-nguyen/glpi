
/** ************************* PROCEDURES ************************* **/

-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;



CREATE OR REPLACE PROCEDURE create_ticket_unique_problem(
  v_fk_count NUMBER := 0;
  p_id IN ticket_cergy.id%TYPE,
  p_user_id IN ticket_cergy.user_id%TYPE,
  p_description IN ticket_cergy.description%TYPE,
  p_ticket_date IN ticket_cergy.ticket_date%TYPE,
  p_computer_id IN ticket_cergy.computer_id%TYPE,
  p_computer_device_id IN ticket_cergy.computer_device_id%TYPE,
  p_software_id IN ticket_cergy.software_id%TYPE,
  p_ville IN ticket_cergy.ville%TYPE
) AS
-- ################## Check if multiple foreign keys are specified ##################
BEGIN
  IF p_computer_id IS NOT NULL THEN
    v_fk_count := v_fk_count + 1;
  END IF;
  IF p_computer_device_id IS NOT NULL THEN
    v_fk_count := v_fk_count + 1;
  END IF;
  IF p_software_id IS NOT NULL THEN
    v_fk_count := v_fk_count + 1;
  END IF;   
  IF v_fk_count > 1 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Cannot specify more than one foreign key');
  END IF;
   
  INSERT INTO ticket_cergy (id, user_id, description, ticket_date, computer_id, computer_device_id, software_id, ville)
  VALUES (p_id, p_user_id, p_description, p_ticket_date, p_computer_id, p_computer_device_id, p_software_id, p_ville);
  
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
   p_ville IN ticket_cergy.ville%TYPE
) AS
BEGIN
   INSERT INTO ticket_cergy(id, user_id, description, ticket_date, computer_id, computer_device_id, software_id, ville)
   VALUES(p_id, p_user_id, p_description, p_ticket_date, p_computer_id, p_computer_device_id, p_software_id, p_ville);
   
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

-- EXECUTION QUI MARCHE : on utilise un id qui n'existe pas
DELETE FROM ticket_cergy WHERE id = 5050;
EXECUTE create_ticket(5050, 1001, 'Probleme de clavier', SYSDATE, NULL, 3002, NULL, 'Cergy');

-- EXECUTION QUI NE MARCHE PAS ET LANCE UNE EXCEPTION : on utilise un id qui existe déjà
EXECUTE create_ticket(5001, 1001, 'Probleme de clavier', SYSDATE, NULL, NULL, NULL, 'Cergy');

-- On vérifie que le ticket a bien été créé
select * from ticket_cergy;
/****************************************************************************************/






