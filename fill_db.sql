INSERT INTO glpi_computers (id, name, inventory_number, ip_address, location_id) VALUES (1, 'Ordinateur 1', 'INV-7890', '192.168.0.3', 2);
INSERT INTO glpi_computers (id, name, inventory_number, ip_address, location_id) VALUES (2, 'Ordinateur 2', 'INV-1234', '192.168.0.4', 4);
INSERT INTO glpi_computers (id, name, inventory_number, ip_address, location_id) VALUES (3, 'Ordinateur 3', 'INV-1234', '192.168.0.1', 1);
INSERT INTO glpi_computers (id, name, inventory_number, ip_address, location_id) VALUES (4, 'Ordinateur 4', 'INV-5678', '192.168.0.2', 2);
INSERT INTO glpi_computers (id, name, inventory_number, ip_address, location_id) VALUES (5, 'Ordinateur 5', 'INV-9012', '192.168.0.3', 1);

INSERT INTO glpi_users (id,group_id, firstname, lastname, email) VALUES (1, 1,'Alice', 'Da costa', 'alice@example.com');
INSERT INTO glpi_users (id, group_id,  firstname, lastname, email) VALUES (2, 2, 'Bob', 'Dos santos', 'bob@example.com');
INSERT INTO glpi_users (id, group_id, firstname, lastname, email) VALUES (3, 2, 'Charlie','Dupont', 'charlie@example.com');
INSERT INTO glpi_users (id, group_id, firstname, lastname, email) VALUES (4, 4, 'David', 'Ackerman', 'david@example.com');
INSERT INTO glpi_users (id, group_id, firstname, lastname, email) VALUES (5, 3, 'Eva', 'Richelieu', 'eva@example.com');

INSERT INTO glpi_groups (id, name, description) VALUES (1, 'Admins', 'Administrators group');
INSERT INTO glpi_groups (id, name, description, members) VALUES (2, 'PMO', 'Project Manager Office group', 'David');
INSERT INTO glpi_groups (id, name, description) VALUES (3, 'Developers', 'Developers group');

INSERT INTO glpi_networkports (id, computer_id, mac_address, status) VALUES (1, 1, '00:11:22:33:44:55', 'Actif');
INSERT INTO glpi_networkports (id, computer_id, mac_address, status) VALUES (2, 2, 'AA:BB:CC:DD:EE:FF', 'Inactif');
INSERT INTO glpi_networkports (id, computer_id, mac_address, status) VALUES (3, 3, '11:22:33:44:55:66', 'Actif');
INSERT INTO glpi_networkports (id, computer_id, mac_address, status) VALUES (4, 4, 'AA:BB:CC:DD:EE:FF', 'Inactif');
INSERT INTO glpi_networkports (id, computer_id, mac_address, status) VALUES (5, 5, '00:11:22:33:44:55', 'Actif');

INSERT INTO glpi_networkports_ipaddresses (id, port_id, ip_address) VALUES (1, 1, '192.168.1.100');
INSERT INTO glpi_networkports_ipaddresses (id, port_id, ip_address) VALUES (2, 2, '192.168.1.101');
INSERT INTO glpi_networkports_ipaddresses (id, port_id, ip_address) VALUES (3, 3, '192.168.1.102');
INSERT INTO glpi_networkports_ipaddresses (id, port_id, ip_address) VALUES (4, 4, '192.168.1.103');
INSERT INTO glpi_networkports_ipaddresses (id, port_id, ip_address) VALUES (5, 5, '192.168.1.104');

INSERT INTO glpi_networks (id, name, ip_range) VALUES (1, 'R�seau local', '192.168.1.0/24');
INSERT INTO glpi_networks (id, name, ip_range) VALUES (2, 'R�seau DMZ', '10.0.0.0/24');
INSERT INTO glpi_networks (id, name, ip_range) VALUES (3, 'R�seau invit�', '172.16.0.0/24');
INSERT INTO glpi_networks (id, name, ip_range) VALUES (4, 'R�seau de test', '192.168.2.0/24');
INSERT INTO glpi_networks (id, name, ip_range) VALUES (5, 'R�seau de d�veloppement', '192.168.3.0/24');

INSERT INTO glpi_networkequipments (id, name, type) VALUES (1, 'Switch1', 'Switch');
INSERT INTO glpi_networkequipments (id, name, type) VALUES (2, 'Routeur1', 'Routeur');
INSERT INTO glpi_networkequipments (id, name, type) VALUES (3, 'Firewall1', 'Firewall');
INSERT INTO glpi_networkequipments (id, name, type) VALUES (4, 'Serveur1', 'Serveur');
INSERT INTO glpi_networkequipments (id, name, type) VALUES (5, 'Imprimante1', 'Imprimante');

INSERT INTO glpi_networkequipmentports (id, equipment_id, port_number) VALUES (1, 1, 1);
INSERT INTO glpi_networkequipmentports (id, equipment_id, port_number) VALUES (2, 1, 2);
INSERT INTO glpi_networkequipmentports (id, equipment_id, port_number) VALUES (3, 2, 1);
INSERT INTO glpi_networkequipmentports (id, equipment_id, port_number) VALUES (4, 2, 2);
INSERT INTO glpi_networkequipmentports (id, equipment_id, port_number) VALUES (5, 3, 1);

INSERT INTO glpi_locations (id, name, address) VALUES (1, 'Bureau A', '10 rue de la Paix');
INSERT INTO glpi_locations (id, name, address) VALUES (2, 'Bureau B', '20 rue de la Liberté');
INSERT INTO glpi_locations (id, name, address) VALUES (3, 'Bureau B', '10 rue des Lilas');
INSERT INTO glpi_locations (id, name, address) VALUES (4, 'Salle de conférence', '20 avenue de la République');
INSERT INTO glpi_locations (id, name, address) VALUES (5, 'Bureau C', '5 rue de la Paix');

INSERT INTO glpi_items_networkports (id, computer_id, port_id) VALUES (1, 1, 1);
INSERT INTO glpi_items_networkports (id, computer_id, port_id) VALUES (2, 2, 2);
INSERT INTO glpi_items_networkports (id, computer_id, port_id) VALUES (3, 3, 3);
INSERT INTO glpi_items_networkports (id, computer_id, port_id) VALUES (4, 4, 4);
INSERT INTO glpi_items_networkports (id, computer_id, port_id) VALUES (5, 5, 5);

INSERT INTO glpi_items_networks (id, computer_id, network_id) VALUES (1, 1, 1);
INSERT INTO glpi_items_networks (id, computer_id, network_id) VALUES (2, 2, 2);
INSERT INTO glpi_items_networks (id, computer_id, network_id) VALUES (3, 3, 3);
INSERT INTO glpi_items_networks (id, computer_id, network_id) VALUES (4, 4, 4);
INSERT INTO glpi_items_networks (id, computer_id, network_id) VALUES (5, 5, 5);

INSERT INTO glpi_computerdevices (id, computer_id, device_name, device_type) VALUES (1, 1, 'Imprimante', 'USB');
INSERT INTO glpi_computerdevices (id, computer_id, device_name, device_type) VALUES (2, 2, 'Scanner', 'USB');
INSERT INTO glpi_computerdevices (id, computer_id, device_name, device_type) VALUES (3, 3, 'Cam�ra', 'USB');
INSERT INTO glpi_computerdevices (id, computer_id, device_name, device_type) VALUES (4, 4, 'Haut-parleur', 'USB');
INSERT INTO glpi_computerdevices (id, computer_id, device_name, device_type) VALUES (5, 5, 'Microphone', 'USB');

INSERT INTO glpi_printers (id, name, model, location_id) VALUES (1, 'HP LaserJet Pro', 'M102a', 2);
INSERT INTO glpi_printers (name, model, location_id) VALUES ('Epson EcoTank', 'L3150', 3);
INSERT INTO glpi_printers (id, name, model) VALUES (3, 'Canon PIXMA', 'TS3320', 1);
INSERT INTO glpi_printers (id, name, model, location_id) VALUES (4, 'Brother MFC-L2750DW XL', 'XL', 1);
INSERT INTO glpi_printers (id, name, model, location_id) VALUES (5, 'Samsung Xpress', 'M2020', 2);



INSERT INTO glpi_monitors (id, computer_id, brand, model) VALUES (1, 1, 'Dell', 'SE2417HG');
INSERT INTO glpi_monitors (id, computer_id, brand, model) VALUES (2, 2, 'AOC', 'C24G1');
INSERT INTO glpi_monitors (id, computer_id, brand, model) VALUES (3, 3, 'Asus', 'VG245H');
INSERT INTO glpi_monitors (id, computer_id, brand, model) VALUES (4, 4, 'BenQ', 'GL2480');
INSERT INTO glpi_monitors (id, computer_id, brand, model) VALUES (5, 5, 'LG', '27MK400H-B');