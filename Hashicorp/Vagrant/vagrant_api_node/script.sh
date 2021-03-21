#!/bin/bash

#Updating S.O
sudo apt-get update
sudo apt-get upgrade -y

##Install net tools
apt install net-tools -y

##Instaling gnome
sudo apt install gnome-session gdm3 -y

##Instaling Node.js and npm
sudo apt install nodejs -y
nodejs -v
sudo apt install npm -y

##Instaling Mongodb
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
sudo apt-get install gnupg
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod


sudo reboot

#reference: https://medium.com/@ricardo.zelaya/rest-api-con-nodejs-y-mongodb-846c295ffe49