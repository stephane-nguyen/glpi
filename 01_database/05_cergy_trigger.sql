
-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;

/*********ATTENTION**********/

/*

Ce fichier ne sert à qu'à rassembler les triggers. 
Tout ce fichier est déjà présent dans 02_db_cergy.sql et 03_db_pau.sql, 
à la fin des fichiers.



/************************************ TRIGGER ************************************/


-- à lancer dans user_cergy

/** ===================== CERGY TRIGGER ============================== **/


/*****************************************************************************/
DROP TRIGGER computer_device_inventory;
CREATE OR REPLACE TRIGGER computer_device_inventory
AFTER INSERT OR DELETE ON computer_device_cergy
FOR EACH ROW
DECLARE
  quantite NUMBER;
BEGIN
  IF inserting THEN
    UPDATE inventory SET computer_device_quantity = computer_device_quantity + 1;
  ELSE
    select computer_device_quantity into quantite from inventory;
    IF quantite=0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'WARNING : Computer device is out of stock!');
    ELSE
      UPDATE inventory SET computer_device_quantity = computer_device_quantity - 1;
    END IF;
  END IF;
END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_device_inventory;


-- Commandes pour tester le trigger
select * from inventory;
delete from computer_device_cergy where id = 3050;
INSERT INTO computer_device_cergy (id, name) VALUES (3050, 'projecteur');
delete from computer_device_cergy where id = 3001;
INSERT INTO computer_device_cergy (id, name) VALUES (3001, 'souris');
select * from inventory;
delete from computer_device_cergy where id = 3050;
select * from inventory;
/*****************************************************************************/





/*****************************************************************************/
DROP TRIGGER computer_inventory_trigger;
CREATE OR REPLACE TRIGGER computer_inventory_trigger
AFTER INSERT OR DELETE ON computer_cergy
FOR EACH ROW

BEGIN
  IF inserting THEN
    UPDATE inventory SET computer_quantity = computer_quantity + 1;
  ELSE
    UPDATE inventory SET computer_quantity = computer_quantity - 1;    
  END IF;
END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_inventory_trigger;

-- Commandes pour tester le trigger
select * from inventory;
delete from computer_cergy where id = 2050;
INSERT INTO computer_cergy (id, computer_device_id, software_id, user_id) VALUES (2050, 3001, 4001, 1001);
select * from inventory;
delete from computer_cergy where id = 2050;

/*****************************************************************************/




/*****************************************************************************/
CREATE OR REPLACE TRIGGER software_inventory_trigger
AFTER INSERT OR DELETE ON software
FOR EACH ROW
BEGIN
  IF inserting THEN
    UPDATE inventory
    SET software_quantity = software_quantity + 1;
  ELSE
    UPDATE inventory
    SET software_quantity = software_quantity - 1;
    -- IF inventory.software_quantity <= 0 THEN
    --     UPDATE inventory SET software_quantity = 0;
    --     RAISE_APPLICATION_ERROR(-20001, 'Software is out of stock!');
    -- END IF;
  END IF;
END;
/
-- Commandes pour tester le trigger
INSERT INTO software (id, name) VALUES (4050, 'Linux');
select * from inventory;
delete from software where id = 4050;
select * from inventory;
/*****************************************************************************/


commit;

