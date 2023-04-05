

/************************************ TRIGGER ************************************/



/** ===================== CERGY TRIGGER ============================== **/


/*****************************************************************************/
DROP TRIGGER computer_device_inventory;
CREATE OR REPLACE TRIGGER computer_device_inventory
AFTER INSERT OR DELETE ON computer_device_cergy
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
delete from computer_device_cergy where id = 3050;
INSERT INTO computer_device_cergy (id, name) VALUES (3050, 'projecteur');
select * from inventory;
delete from computer_device_cergy where id = 3050;
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
    -- IF computer_quantity <= 0 THEN
    --     UPDATE inventory SET computer_quantity = 0;
    --     RAISE_APPLICATION_ERROR(-20001, 'Computer is out of stock!');
    -- END IF;
  END IF;
END;
/
-- Pour afficher les erreurs du trigger
SHOW ERRORS TRIGGER computer_inventory_trigger;
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
/*****************************************************************************/




/** ===================== PAU TRIGGER ============================== **/

CREATE OR REPLACE TRIGGER computer_device_inventory
AFTER INSERT OR DELETE ON computer_device_pau
FOR EACH ROW
BEGIN
  IF inserting THEN
    UPDATE inventory SET computer_device_quantity = computer_device_quantity + 1;
  ELSE
    UPDATE inventory SET computer_device_quantity = computer_device_quantity - 1;
    -- IF inventory.computer_device_quantity <= 0 THEN
    --     UPDATE inventory SET computer_device_quantity = 0;
    --     RAISE_APPLICATION_ERROR(-20001, 'computer device is out of stock!');
    -- END IF;
  END IF;
END;
/
/*****************************************************************************/

/*****************************************************************************/
CREATE OR REPLACE TRIGGER computer_inventory_trigger
AFTER INSERT OR DELETE ON computer_device_pau
FOR EACH ROW
BEGIN
  IF inserting THEN
    UPDATE inventory
    SET computer_quantity = computer_quantity + 1;
  ELSE
    UPDATE inventory
    SET computer_quantity = computer_quantity - 1;
    -- IF inventory.computer_quantity <= 0 THEN
    --     UPDATE inventory SET computer_quantity = 0;
    --     RAISE_APPLICATION_ERROR(-20001, 'Computer is out of stock!');
    -- END IF;
  END IF;
END;
/
/*****************************************************************************/




