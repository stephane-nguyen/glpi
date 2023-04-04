-- ####################### QUERY PLANS #######################

EXPLAIN PLAN FOR 
SELECT name FROM software;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); -- display in readable format 

EXPLAIN PLAN FOR 
SELECT COUNT(*) FROM user_cergy;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR 
SELECT COUNT(*) FROM ticket_cergy;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

CREATE INDEX index_user ON user_cergy(id);
EXPLAIN PLAN FOR 
SELECT firstname, lastname
FROM user_cergy
WHERE id = 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ####################### INDEXES #######################

-- Create an index on the ticket_date column
CREATE INDEX index_mv_tickets ON materialized_view_tickets (ticket_date);
-- Get all tickets from a certain ticket_date
SELECT * FROM materialized_view_tickets
WHERE ticket_date >= TO_DATE('2023-04-01', 'YYYY-MM-DD'); 

-- Get all tickets related to computer
CREATE INDEX index_mv_tickets ON materialized_view_tickets (computer_id);
SELECT * FROM materialized_view_tickets
WHERE computer_id IS NOT NULL;

-- Get all tickets related to computer device
CREATE INDEX index_mv_tickets ON materialized_view_tickets (computer_device_id);
SELECT * FROM materialized_view_tickets
WHERE computer_device_id IS NOT NULL;

-- Get all tickets related to software
CREATE INDEX index_mv_tickets ON materialized_view_tickets (software_id);
SELECT * FROM materialized_view_tickets
WHERE software_id IS NOT NULL;

