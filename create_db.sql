DROP TABLE glpi_computers CASCADE CONSTRAINTS;
CREATE TABLE glpi_computers (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    inventory_number VARCHAR2(50),
    ip_address VARCHAR2(50),
    location_id NUMBER,
    FOREIGN KEY (location_id) REFERENCES glpi_locations(id)
);

DROP TABLE glpi_printers CASCADE CONSTRAINTS;
CREATE TABLE glpi_printers (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    model VARCHAR2(50),
    location_id NUMBER,
    FOREIGN KEY (location_id) REFERENCES glpi_locations(id)
);

DROP TABLE glpi_locations CASCADE CONSTRAINTS;
CREATE TABLE glpi_locations (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    address VARCHAR2(255)
);

DROP TABLE glpi_users CASCADE CONSTRAINTS;
CREATE TABLE glpi_users (
    id NUMBER PRIMARY KEY,
    group_id NUMBER,
    firstname VARCHAR2(255),
    lastname VARCHAR2(255),
    email VARCHAR2(255),
    FOREIGN KEY (group_id) REFERENCES glpi_groups(id)
);

DROP TABLE glpi_groups CASCADE CONSTRAINTS;
CREATE TABLE glpi_groups (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    description VARCHAR2(255),
    members VARCHAR2(1024)
);

DROP TABLE glpi_networkports CASCADE CONSTRAINTS;
CREATE TABLE glpi_networkports (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    mac_address VARCHAR2(50),
    status VARCHAR2(50),
    FOREIGN KEY (computer_id) REFERENCES glpi_computers(id)
);

DROP TABLE glpi_networkports_ipaddresses CASCADE CONSTRAINTS;
CREATE TABLE glpi_networkports_ipaddresses (
    id NUMBER PRIMARY KEY,
    port_id NUMBER,
    ip_address VARCHAR2(50),
    FOREIGN KEY (port_id) REFERENCES glpi_networkports(id)
);

DROP TABLE glpi_networks CASCADE CONSTRAINTS;
CREATE TABLE glpi_networks (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    ip_range VARCHAR2(255)
);

DROP TABLE glpi_networkequipments CASCADE CONSTRAINTS;
CREATE TABLE glpi_networkequipments (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    type VARCHAR2(50)
);

DROP TABLE glpi_networkequipmentports CASCADE CONSTRAINTS;
CREATE TABLE glpi_networkequipmentports (
    id NUMBER PRIMARY KEY,
    equipment_id NUMBER,
    port_number NUMBER,
    FOREIGN KEY (equipment_id) REFERENCES glpi_networkequipments(id)
);

DROP TABLE glpi_items_networkports;
CREATE TABLE glpi_items_networkports (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    port_id NUMBER,
    FOREIGN KEY (computer_id) REFERENCES glpi_computers(id),
    FOREIGN KEY (port_id) REFERENCES glpi_networkports(id)
);

DROP TABLE glpi_items_networks;
CREATE TABLE glpi_items_networks (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    network_id NUMBER,
    FOREIGN KEY (computer_id) REFERENCES glpi_computers(id),
    FOREIGN KEY (network_id) REFERENCES glpi_networks(id)
);

DROP TABLE glpi_computerdevices CASCADE CONSTRAINTS;
CREATE TABLE glpi_computerdevices (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    device_name VARCHAR2(255),
    device_type VARCHAR2(50),
    FOREIGN KEY (computer_id) REFERENCES glpi_computers(id)
);
DROP TABLE glpi_monitors CASCADE CONSTRAINTS;
CREATE TABLE glpi_monitors (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    brand VARCHAR2(50),
    model VARCHAR2(50),
    FOREIGN KEY (computer_id) REFERENCES glpi_computers(id)
);