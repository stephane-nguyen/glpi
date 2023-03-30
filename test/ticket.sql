-- should get an error : cannot specify more than one foreign key 
BEGIN
   create_ticket_for_unique_problem(
      p_ticket_id => 2,
      p_description => 'Computer issue with both device and software',
      p_date => SYSDATE,
      p_computer_id => 1234,
      p_device_id => 5678,
      p_software_id => 9012
   );
END;
/

BEGIN
   create_ticket_for_unique_problem(
      p_ticket_id => 2,
      p_description => 'Computer and usb key issue',
      p_date => SYSDATE,
      p_computer_id => 1,
      p_device_id => 1
      );
END;
/

-- should work 
BEGIN
   create_ticket_for_unique_problem(
      p_ticket_id => 1,
      p_ticket_desc => 'Computer issue',
      p_ticket_date => SYSDATE,
      p_computer_id => 1234,
      p_device_id => NULL,
      p_software_id => NULL
   );
END;
/

-- insert a duplicate in the table 
BEGIN
   create_ticket_for_unique_problem(
      p_ticket_id => 1,
      p_ticket_desc => 'Computer issue',
      p_ticket_date => SYSDATE,
      p_computer_id => 1234,
      p_device_id => NULL,
      p_software_id => NULL
   );
END;
/
  
-- Create a ticket with a computer and computer_device issue
BEGIN
  create_ticket(
      p_description => 'Computer not turning on and keyboard keys broken',
      p_computer_id => 123,
      p_computer_device_id => 456,
      p_software_id => NULL
  );
END;
/
