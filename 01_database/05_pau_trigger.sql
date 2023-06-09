
-- Lignes de code à entrer dans le terminal dès le début pour AFFICHER CORRECTEMENT :
set wrap off; 
set linesize 250;

/*********ATTENTION**********/

/*

Ce fichier ne sert à qu'à rassembler les triggers. 
Tout ce fichier est déjà présent dans 02_db_cergy.sql et 03_db_pau.sql, 
à la fin des fichiers.


/** ===================== PAU TRIGGER ============================== **/

/*****************************************************************************/
DROP TRIGGER computer_device_inventory;
CREATE OR REPLACE TRIGGER computer_device_inventory
AFTER INSERT OR DELETE ON computer_device_pau
FOR EACH ROW
BEGIN
    IF inserting THEN
    UPDATE inventory SET computer_device_quantity = computer_device_quantity + 1;
  ELSE
    UPDATE inventory SET computer_device_quantity = computer_device_quantity - 1;
  END IF;

  -- IF inventory.computer_device_quantity < 0 THEN
  --     UPDATE inventory SET computer_device_quantity = 0;
  --     RAISE_APPLICATION_ERROR(-20001, 'Computer device is out of stock!');
  -- END IF;

END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_device_inventory;


-- Commandes pour tester le trigger
select * from inventory;
delete from computer_device_pau where id = 3050;
INSERT INTO computer_device_pau (id, name) VALUES (3050, 'projecteur');
select * from inventory;
delete from computer_device_pau where id = 3050;
/*****************************************************************************/



/*****************************************************************************/
DROP TRIGGER computer_inventory_trigger;
CREATE OR REPLACE TRIGGER computer_inventory_trigger
AFTER INSERT OR DELETE ON computer_pau
FOR EACH ROW

BEGIN
  IF inserting THEN
    UPDATE inventory SET computer_quantity = computer_quantity + 1;
  ELSE
    UPDATE inventory SET computer_quantity = computer_quantity - 1;    
    -- IF computer_quantity <= 0 THEN
    --     UPDATE inventory SET computer_quantity = 0;
    --     RAISE_APPLICATION_ERROR(-20001, 'Computer is out of stock!');
    -- END IF;
  END IF;
END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_inventory_trigger;

-- Commandes pour tester le trigger
select * from inventory;
delete from computer_pau where id = 2050;
INSERT INTO computer_pau (id, computer_device_id, software_id, user_id) VALUES (2050, 3001, 4001, 1001);
select * from inventory;
delete from computer_pau where id = 2050;

/*****************************************************************************/





commit;



