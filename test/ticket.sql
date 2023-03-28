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
      p_ticket_id => 1,
      p_ticket_desc => 'Computer issue',
      p_ticket_date => SYSDATE,
      p_computer_id => 1234,
      p_device_id => NULL,
      p_software_id => NULL
   );
END;
/

