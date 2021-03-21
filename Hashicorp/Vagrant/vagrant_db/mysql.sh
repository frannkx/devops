#!/bin/bash

### Initial Server Setup### 

#echo "Initial Server Setup"

##Creating a New User
#adduser user

#Granting Administrative Privileges
#usermod -aG sudo user

##Setting Up a Basic Firewall

#view a firewall profile
#sudo ufw app list

#Allow OpenSSH on firewall
#sudo ufw allow OpenSSH

#Enable Firewall
#sudo ufw enable

#view a Firewall status
#sudo ufw status

##Enabling External Access for Your Regular User
#rsync --archive --chown=sammy:sammy ~/.ssh /home/sammy

#echo "Initial Server Setup is end"

#reference: https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04
###

### Set Up SSH Keys on Ubuntu 20.04

#on client machine
#ssh-keygen

#Copying the Public Key to Your Ubuntu Server
#ssh-copy-id username@remote_host
#cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys && chmod -R go= ~/.ssh && cat >> ~/.ssh/authorized_keys"

#echo "Set Up SSH Keys on Ubuntu 20.04 is end"

### 

#Updating S.O
sudo apt-get update
sudo apt-get upgrade -y

##Install net tools
apt install net-tools -y

##Instaling gnome
sudo apt install gnome-session gdm3 -y
#referenfe https://goto-linux.com/es/2020/6/9/como-instalar-gnome-en-ubuntu-20.04-lts-focal-fossa/
##Installing VNC server
sudo apt-get install tightvncserver -y

##Installing Microk8s
sudo snap install microk8s --classic
sudo ufw allow in on cni0 && sudo ufw allow out on cni0
sudo ufw default allow routed
sudo usermod -a -G microk8s vagrant
sudo chown -f -R vagrant ~/.kube
newgrp microk8s
microk8s enable dns dashboard storage
#https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s?&_ga=2.50303142.1250345174.1615700359-599421617.1614979335#5-host-your-first-service-in-kubernetes
#https://kubernetes.io/docs/tutorials/kubernetes-basics/
sudo apt-get install firefox -y

echo "alias kubectl='microk8s kubectl'" >> .profile

sudo reboot

#Installing Mysql
#sudo apt update
#sudo apt install mysql-server -y

#Configuring Mysql
#sudo mysql_secure_installation

#Create a dedicated user
#CREATE USER 'cxadm'@'localhost' IDENTIFIED WITH authentication_plugin BY 'P4$$w0rd';
#CREATE USER 'cxadm'@'localhost' IDENTIFIED BY 'P4$$w0rd';

#GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'cxadm'@'localhost' WITH GRANT OPTION;

#FLUSH PRIVILEGES;

#Testing Mysql
#systemctl status mysql.service
#sudo mysqladmin -p -u sammy version


