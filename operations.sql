-- ####################### QUERY PLANS #######################

EXPLAIN PLAN FOR 
SELECT software_name FROM software;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY); -- display in readable format 

EXPLAIN PLAN FOR 
SELECT COUNT(*) FROM user;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

CREATE INDEX index_user ON user(id);
EXPLAIN PLAN FOR 
SELECT firstname, lastname
FROM user
WHERE id = 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


-- ####################### INDEXES #######################

-- Create an index on the date column
CREATE INDEX index_date ON ticket(date);
-- Get all tickets from a certain date
SELECT id, description, date
FROM ticket
WHERE date >= TO_DATE('2023-04-03', 'YYYY-MM-DD'); 

CREATE INDEX index_ticket_computers
ON ticket(computer_id, computer_device_id, software_id);
-- get all tickets related to computers
SELECT * FROM ticket 
WHERE computer_id = 1
AND computer_device_id = 'keyboard'
AND software_id = NULL;

