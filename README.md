## SF Project
This project utilizes Docker and Kubernetes for implementation. Both Task 1 and Task 2 are implemented using Docker. Furthermore, Task 2 is additionally implemented using Kubernetes.


**Description:**
The SF project consists of two tasks. The first task involves integrating LDAP with other services, such as a MySQL database, to enable users to authenticate across multiple services using a single password. The second task requires the development of a basic Twitter application that utilizes a MySQL database.



Task2  contains the following files:

tables.sql: This script contains the Data Definition Language (DDL) statements to create the relational tables for Twitter schema, along with the necessary constraints.

procedures.sql: This script includes various procedures that execute complex queries in our system.

tw_app.sh: This file serves as a user interface, allowing us to interact with the database through the command-line interface (CLI). It incorporates all the features implemented for our designed Twitter system.

**Requirements**
*Task1
1 server1( Oracle Linux) for Docker host
Installation Docker-compose

*Task2
1 server1( Oracle Linux) for Master

2 servers (Oracle Linux) for Workers

