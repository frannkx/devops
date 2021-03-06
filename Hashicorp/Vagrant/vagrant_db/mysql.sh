#!/bin/bash

#Installing Mysql
sudo apt update
sudo apt install mysql-server -y

#Configuring Mysql
sudo mysql_secure_installation

#Create a dedicated user
#CREATE USER 'cxadm'@'localhost' IDENTIFIED WITH authentication_plugin BY 'P4$$w0rd';
CREATE USER 'cxadm'@'localhost' IDENTIFIED BY 'P4$$w0rd';

GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'cxadm'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

#Testing Mysql
systemctl status mysql.service
sudo mysqladmin -p -u sammy version


