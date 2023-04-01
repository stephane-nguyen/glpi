DECLARE
  v_fk_count NUMBER := 0;
CREATE OR REPLACE PROCEDURE create_ticket_for_unique_problem(
   p_ticket_id IN ticket.id%TYPE,
   p_description IN ticket.description%TYPE,
   p_computer_id IN ticket.computer_id%TYPE,
   p_device_id IN ticket.device_id%TYPE,
   p_software_id IN ticket.software_id%TYPE
) AS
-- ################## Check if multiple foreign keys are specified ##################
BEGIN
  IF p_computer_id IS NOT NULL THEN
    v_fk_count := v_fk_count + 1;
  END IF;
  IF p_device_id IS NOT NULL THEN
    v_fk_count := v_fk_count + 1;
  END IF;
  IF p_software_id IS NOT NULL THEN
    v_fk_count := v_fk_count + 1;
  END IF;
   
   IF v_fk_count > 1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Cannot specify more than one foreign key');
   END IF;
   
   INSERT INTO ticket (ticket_id, description, date, computer_id, computer_device_id, software_id)
   VALUES (p_ticket_id, p_description, p_date, p_computer_id, p_device_id, p_software_id);
   
   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Ticket created successfully');

EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('Error creating ticket');
END;
/

DECLARE
   CURSOR c_tickets IS
      SELECT id, description, date
      FROM ticket
      ORDER BY date DESC;
      
   v_id ticket.id%TYPE;
   v_description ticket.description%TYPE;
   v_date ticket.date%TYPE;
BEGIN
   OPEN c_tickets;
   
   LOOP
      FETCH c_tickets INTO v_id, v_description, v_date;
      EXIT WHEN c_tickets%NOTFOUND;
      
      -- Process the ticket record here, for example print it to the console
      DBMS_OUTPUT.PUT_LINE('Ticket ID: ' || v_id || ', Description: ' || v_description || ', Created Date: ' || v_date);
   END LOOP;
   
   CLOSE c_tickets;
END;
/

-- from cergy site, display all tickets
SELECT id, description, date
FROM ticket_cergy
UNION ALL
SELECT id, description, date
FROM ticket_pau@cergy_to_pau;

