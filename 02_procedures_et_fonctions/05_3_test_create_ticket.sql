


-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;




-- EXECUTION QUI MARCHE : on utilise un id qui n'existe pas
DELETE FROM ticket_cergy WHERE id = 5050;
EXECUTE create_ticket(5050, 1001, 'Probleme de clavier', SYSDATE, NULL, 3002, NULL, 'Cergy');





-- EXECUTION QUI NE MARCHE PAS ET LANCE UNE EXCEPTION : on utilise un id qui existe déjà
EXECUTE create_ticket(5001, 1001, 'Probleme de clavier', SYSDATE, NULL, NULL, NULL, 'Cergy');




-- On vérifie que le ticket a bien été créé
select * from ticket_cergy;
/****************************************************************************************/



-- -- should get an error : cannot specify more than one foreign key 
-- EXECUTE create_ticket_unique_problem(
--    p_id => 2,
--    p_user_id => 1001,
--    p_description => 'Computer issue with both device and software',
--    p_ticket_date => SYSDATE,
--    p_computer_id => 2005,
--    p_computer_device_id => 3001,
--    p_software_id => 4001,
--    p_city => 'Cergy'
-- );
-- /

-- EXECUTE create_ticket_unique_problem(
--    p_id => 3,
--    p_user_id => 1002,
--    p_description => 'Computer and usb key issue',
--    p_ticket_date => SYSDATE,
--    p_computer_id => 2005,
--    p_computer_device_id => 3002,
--    p_software_id => NULL,
--    p_city => 'Cergy'
-- );
-- /

-- -- should work 
-- EXECUTE create_ticket_unique_problem(
--    p_id => 1,
--    p_user_id => 123,
--    p_description => 'Computer issue',
--    p_ticket_date => SYSDATE,
--    p_computer_id => 2005,
--    p_computer_device_id => NULL,
--    p_software_id => NULL,
--    p_city => 'Cergy'
-- );
