
/** ===================== CERGY TRIGGER ============================== **/
CREATE OR REPLACE TRIGGER computer_inventory_trigger
AFTER INSERT OR DELETE ON computer_device_cergy
FOR EACH ROW
BEGIN
  IF inserting THEN
    UPDATE inventory
    SET computer_quantity = computer_quantity + 1;
  ELSE
    UPDATE inventory
    SET computer_quantity = computer_quantity - 1;
    IF inventory.computer_quantity <= 0 THEN
        UPDATE inventory SET computer_quantity = 0;
        RAISE_APPLICATION_ERROR(-20001, 'Computer is out of stock!');
    END IF;
  END IF;
END;

CREATE OR REPLACE TRIGGER computer_device_inventory_trigger
AFTER INSERT OR DELETE ON computer_device_cergy
FOR EACH ROW
BEGIN
  IF inserting THEN
    UPDATE inventory
    SET computer_device_quantity = computer_device_quantity + 1;
  ELSE
    UPDATE inventory
    SET computer_device_quantity = computer_device_quantity - 1;
    IF inventory.computer_device_quantity <= 0 THEN
        UPDATE inventory SET computer_device_quantity = 0;
        RAISE_APPLICATION_ERROR(-20001, 'computer device is out of stock!');
    END IF;
  END IF;
END;

/** ===================== PAU TRIGGER ============================== **/

CREATE OR REPLACE TRIGGER computer_device_inventory_trigger
AFTER INSERT OR DELETE ON computer_device_pau
FOR EACH ROW
BEGIN
  IF inserting THEN
    UPDATE inventory
    SET computer_device_quantity = computer_device_quantity + 1;
  ELSE
    UPDATE inventory
    SET computer_device_quantity = computer_device_quantity - 1;
    IF inventory.computer_device_quantity <= 0 THEN
        UPDATE inventory SET computer_device_quantity = 0;
        RAISE_APPLICATION_ERROR(-20001, 'computer device is out of stock!');
    END IF;
  END IF;
END;

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
    IF inventory.computer_quantity <= 0 THEN
        UPDATE inventory SET computer_quantity = 0;
        RAISE_APPLICATION_ERROR(-20001, 'Computer is out of stock!');
    END IF;
  END IF;
END;

/** ===================== PAU TRIGGER ============================== **/

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
    IF inventory.software_quantity <= 0 THEN
        UPDATE inventory SET software_quantity = 0;
        RAISE_APPLICATION_ERROR(-20001, 'Software is out of stock!');
    END IF;
  END IF;
END;