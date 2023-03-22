-- USER MANAGEMENT  

DROP TABLE glpi_user CASCADE CONSTRAINTS;
CREATE TABLE glpi_user (
    id NUMBER PRIMARY KEY,
    group_id NUMBER,
    firstname VARCHAR2(30),
    lastname VARCHAR2(30),
    email VARCHAR2(55),
    FOREIGN KEY (group_id) REFERENCES glpi_group(id)
);

DROP TABLE glpi_group CASCADE CONSTRAINTS;
CREATE TABLE glpi_group (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(255),
    description VARCHAR2(255),
    members VARCHAR2(1024)
);

-- COMPUTER HARDWARE MANAGEMENT 

DROP TABLE glpi_computer CASCADE CONSTRAINTS;
CREATE TABLE glpi_computer (
    id NUMBER PRIMARY KEY,
    ip_address VARCHAR2(50),
    location_id NUMBER,
    user_id NUMBER,
    FOREIGN KEY (location_id) REFERENCES glpi_location(id)
    FOREIGN KEY (user_id) REFERENCES glpi_user(id)
);

-- keyboard, monitor ...
DROP TABLE glpi_computer_device CASCADE CONSTRAINTS;
CREATE TABLE glpi_computer_device (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    device_name VARCHAR2(50),
    device_type VARCHAR2(50),
    FOREIGN KEY (computer_id) REFERENCES glpi_computer(id)
);

DROP TABLE glpi_location CASCADE CONSTRAINTS;
CREATE TABLE glpi_location (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    address VARCHAR2(50)
);

-- Information about routers, commutators ... 
DROP TABLE glpi_network_equipment CASCADE CONSTRAINTS;
CREATE TABLE glpi_network_equipment (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    type VARCHAR2(50) -- hub, switch, gateway, router ... 
);

-- MANAGEMENT OF NETWORK STRUCTURE INFORMATION 

-- Information about the network of the organization 
DROP TABLE glpi_network CASCADE CONSTRAINTS;
CREATE TABLE glpi_network (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    ip_range VARCHAR2(255)
);

-- Link between computers and networks : which computer is associated with which network. 

DROP TABLE glpi_network_port CASCADE CONSTRAINTS;
CREATE TABLE glpi_network_port (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    mac_address VARCHAR2(50),
    status VARCHAR2(50),
    FOREIGN KEY (computer_id) REFERENCES glpi_computer(id)
);

-- Information about IP addresses associated with each network port 
DROP TABLE glpi_network_port_ip_address CASCADE CONSTRAINTS;
CREATE TABLE glpi_network_port_ip_address (
    id NUMBER PRIMARY KEY,
    port_id NUMBER,
    ip_address VARCHAR2(50),
    FOREIGN KEY (port_id) REFERENCES glpi_network_port(id)
);

-- Information about the ports on the network equipements :  which equipment the port is associated with.
DROP TABLE glpi_network_equipment_port CASCADE CONSTRAINTS;
CREATE TABLE glpi_networkequipmentport (
    id NUMBER PRIMARY KEY,
    equipment_id NUMBER,
    port_number NUMBER,
    FOREIGN KEY (equipment_id) REFERENCES glpi_network_equipment(id)
);

-- Link between computers and port networks : which computer is connected to which network port.
DROP TABLE glpi_item_network_port;
CREATE TABLE glpi_item_network_port (
    id NUMBER PRIMARY KEY,
    computer_id NUMBER,
    port_id NUMBER,
    FOREIGN KEY (computer_id) REFERENCES glpi_computer(id),
    FOREIGN KEY (port_id) REFERENCES glpi_network_port(id)
);

