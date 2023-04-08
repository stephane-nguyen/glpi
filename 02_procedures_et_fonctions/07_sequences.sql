



-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;


-- à lancer dans user_cergy


/************** SEQUENCES **************/


/***********************************************/
-- Génération d'utilisateurs au hasard dans la table user_cergy
DROP SEQUENCE user_cergy_seq;
CREATE SEQUENCE user_cergy_seq START WITH 1006 INCREMENT BY 1 MAXVALUE 1015 NOCYCLE NOCACHE;
BEGIN
  FOR i IN 1006..1015 LOOP
    DELETE FROM computer_device_cergy WHERE id = i;   
    INSERT INTO user_cergy (id, firstname, lastname, email) VALUES (user_cergy_seq.NEXTVAL, 'UTILISATEURS', 'SEQUENCES', 'UTILISATEURS@SEQUENCES.fr');
  END LOOP;
END;
/
--Vérification
SELECT * FROM user_cergy;
/***********************************************/




/***********************************************/
-- Insertion d'outils au hasard dans la table computer_device_cergy
DROP SEQUENCE seq_tool_cergy;
CREATE SEQUENCE seq_tool_cergy START WITH 3006 INCREMENT BY 1 MAXVALUE 3015 NOCYCLE NOCACHE;
DECLARE
  tool_name VARCHAR2(50);
BEGIN
  FOR i IN 3006..3015 LOOP
    DELETE FROM computer_device_cergy WHERE id = i;
    CASE round(dbms_random.value(1, 5))
      WHEN 1 THEN tool_name := 'souris';
      WHEN 2 THEN tool_name := 'clavier';
      WHEN 3 THEN tool_name := 'écran';
      WHEN 4 THEN tool_name := 'cable';
      WHEN 5 THEN tool_name := 'imprimante';
    END CASE;    
    INSERT INTO computer_device_cergy (id, name) VALUES (seq_tool_cergy.NEXTVAL, tool_name);
  END LOOP;
END;
/
--Vérification
SELECT * FROM computer_device_cergy;


-- REMARQUE A SOI MEME :
-- CREATE OR REPLACE SEQUENCE n'existe pas, c'est uniquement pour les procédures
/***********************************************/


commit;



