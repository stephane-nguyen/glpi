


-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;

-- à lancer dans user_cergy

-- ####################### INDEXES #######################


-- Create an index on the ticket_date column
drop index index_mv_tickets;
CREATE INDEX index_mv_tickets ON materialized_view_tickets (ticket_date);
-- Get all tickets from a certain ticket_date
SELECT * FROM materialized_view_tickets
WHERE ticket_date >= TO_DATE('2023-04-01', 'YYYY-MM-DD'); 



-- Get all tickets related to computer
drop index index_mv_tickets;
CREATE INDEX index_mv_tickets ON materialized_view_tickets (computer_id);
SELECT * FROM materialized_view_tickets
WHERE computer_id IS NOT NULL;



-- Get all tickets related to computer device
drop index index_mv_tickets;
CREATE INDEX index_mv_tickets ON materialized_view_tickets (computer_device_id);
SELECT * FROM materialized_view_tickets
WHERE computer_device_id IS NOT NULL;



-- Get all tickets related to software
drop index index_mv_tickets;
CREATE INDEX index_mv_tickets ON materialized_view_tickets (software_id);
SELECT * FROM materialized_view_tickets
WHERE software_id IS NOT NULL;


