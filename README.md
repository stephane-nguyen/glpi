# glpi

> The scope of the project covers aspects related GLPI's management of computer equipment, users and information on the network structure. <br>
#### The project consists of : 
- Defining a new database using the following notions: users, roles, tablespace, cluster, indexes, views, PLSQL (triggers, cursors, procedures) distributed databases (BDDR), query plan.
- Validating your structure by performing performance tests on your database using a substantial test set generated in PL/SQL.

## Entity Relationship Diagram
![Alt Entity Relationship Diagram](./erd.png?raw=true "Entity Relationship Diagram")
## Distributed Database
![Alt Distributed Database](./distributed_database.png?raw=true "Distributed Database")

Materialized views have been created to improve performance and storage. These are temporary tables that use the query results of a table. Thus, on the Pau site we have created views (for example the Inventory view because it is Cergy that manages the hardware stocks). Simply access the view to see the available hardware and no need to query the Inventory table.

Materialized view materialized_view_ticket is created to reduce network costs because ticket_pau and ticket_cergy are not on the same site. It is the union of the tables ticket_cergy and ticket_pau


Horizontal fragmentations on the following tables according to their city to improve the performance and decrease the time of requests: 
- the user table is separated into user_cergy, user_pau
- the computer table is separated into computer_cergy, computer_pau
- the table computer_device is separated into computer_device _cergy, computer_device _pau
- the ticket table is separated into ticket_cergy, ticket_pau
- the user table is separated into user_cergy, user_pau


Clusters are used when we have tables that are frequently requested together in queries. They are used to group tables on the disk to reduce the cost of query operations and improve query performance.

Triggers have been implemented when the ticket table is used. These are blocks of code that run when a specific request has been requested.

Indexes have been implemented so that the queries are more efficient: instead of browsing the whole table, we have a precise block of info of what we are looking for, we must read only this block.

Query plans have been implemented to see the executions and information related to requests as their cost.

Sequences to create a unique identifier to create a user or randomly insert computer hardware (keyboard, mouse, etc.) into the computer_device_cergy table 

