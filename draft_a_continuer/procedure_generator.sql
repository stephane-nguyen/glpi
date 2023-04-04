CREATE OR REPLACE PROCEDURE generate_user
IS
  i INT DEFAULT 0;
BEGIN
  WHILE i < 20 LOOP
    INSERT INTO user (id, firstname, lastname, email)
    VALUES (seq_client.NEXTVAL, SUBSTR(DBMS_RANDOM.STRING('U', 10), 1, 10), SUBSTR(DBMS_RANDOM.STRING('U', 10), 1, 10), 
            SUBSTR(DBMS_RANDOM.STRING('U', 10), 1, 10), FLOOR(DBMS_RANDOM.VALUE(1, 100)), 
            CASE FLOOR(DBMS_RANDOM.VALUE(0, 3)) WHEN 0 THEN 'Homme' WHEN 1 THEN 'Femme' ELSE 'Autre' END);
    i := i + 1;
  END LOOP;
END;

/


CALL generer_clients_aleatoires();