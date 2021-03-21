#!/bin/bash

echo "###### Desinstalando rastros de Docker ######"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo


sudo yum-config-manager --enable docker-ce-nightly

sudo yum-config-manager --enable docker-ce-test

sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf upgrade -y
sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "###### Instalando Docker ######"
sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo systemctl start docker
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
#exec su -l $USER

#echo "###### Instalando Kubectl ######"
#snap install kubectl --classic
#kubectl version --client

echo "###### Instalando Microk8s ######"
sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
newgrp microk8s
microk8s status --wait-ready

#Setup firewall to allow comunication inter pods or internet
#sudo ufw allow in on cni0 && sudo ufw allow out on cni0
#sudo ufw default allow routed

#Open port in the firewall
#Reference https://docs.oracle.com/en/operating-systems/olcne/start/F22532.pdf page 12 https://www.oracle.com/database/technologies/oracle-database-software-downloads.html 
sudo firewall-cmd --zone=trusted --add-interface=cni0 --permanent
sudo firewall-cmd --add-port=8090/tcp --permanent
sudo firewall-cmd --add-port=10250/tcp --permanent
sudo firewall-cmd --add-port=10255/tcp --permanent
sudo firewall-cmd --add-port=8472/udp --permanent

#Restart the firewall to take effect
sudo systemctl restart firewalld.service


#Enable addons Microk8s
microk8s enable dns dashboard storage
#Disable addons Microk8s
#$microk8s disable dns dashboard storage

#Accessing the Kubernetes dashboard



#sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#sudo chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl
#kubectl version --client

#Install Kubectl
#sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
#echo "$(<kubectl.sha256) kubectl" | sha256sum --check
#sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#kubectl version --client

#Install Minikube
#sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
#sudo install minikube-linux-amd64 /usr/local/bin/minikube
#sudo gpasswd -a $USER docker
#exec su -l $USER
#minikube start

#Install Microk8s
