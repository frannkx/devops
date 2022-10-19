
##Listar programas instalados

#Ubuntu
dpkg --get-selections

#RedHat
rpm -qa >lista_paquetes

#Archlinux
pacman -Qe >lista_paquetes

##Instalar Stress

#RedHat
sudo amazon-linux-extras install epel -y
sudo yum install stress -y

#referencia: https://gist.github.com/mikepfeiffer/d27f5c478bef92e8aff4241154b77e54 / https://www.networkworld.com/article/3563334/how-to-stress-test-your-linux-system.html

#Oracle Linux
sudo rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install stress -y

#referencia: https://snapcraft.io/install/stress-ng/rhel /https://yum.oracle.com/getting-started.html#installing-software-from-oracle-linux-yum-server

#SSH Tuneling over bastion host
bastionhost 18.205.19.21
web 172.31.88.224

ssh -i ~/.ssh/srv-key.pem ec2-user@18.205.19.21

ssh -i ~/.ssh/srv-key.pem -L 127.0.0.1:33306:172.31.88.224:3306 ec2-user@18.205.19.21

#referencia: https://www.ssh.com/academy/ssh/tunneling/example
#https://docs.aws.amazon.com/es_es/mwaa/latest/userguide/tutorials-private-network-bastion.html


#github autentication
https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls


## Upgrade de version de fedora 34 a 36

sudo dnf upgrade --refresh
sudo dnf install dnf-plugin-system-upgrade
sudo dnf system-upgrade download --releasever=36
sudo dnf system-upgrade reboot


#ouput
Transaction saved to /var/lib/dnf/system-upgrade/system-upgrade-transaction.json.
Download complete! Use 'dnf system-upgrade reboot' to start the upgrade.
To remove cached metadata and transaction use 'dnf system-upgrade clean'
Los paquetes descargados se han guardado en caché para la próxima transacción.
Puede borrar los paquetes de la caché ejecutando 'dnf clean packages'.

#referencia
https://yourgeekweb.com/es/2019/03/24/como-actualizar-fedora-desde-la-terminal/

## Cambio de entorno grafico en Fedora ##
dnf grouplist -v
sudo dnf install [@environment-name] -y
sudo dnf install switchdesk switchdesk-gui -y 
sudo switchdesk kde 
sudo dnf remove [@environment-name]

#Reference: https://noviello.it/es/como-instalar-y-cambiar-entornos-de-escritorio-en-fedora/

## Gestion de usuarios##

# Sacar sesion de usuario 

sudo pkill -9 -u {user}


## Grabar iso a USB ##

dd bs=4M if=/home/gollum23/Downloads/manjaro-kde-21.0.4-210506-linux510.iso of=/dev/sdc status=progress oflag=sync

## Instalacion de node.js#

sudo apt install nodejs

#Instalacion por nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | zsh

zsh
 
 nvm install --lts

node -v

#Referencia: https://github.com/nvm-sh/nvm#manual-install

## Proyecto inicial react js

npx create-react-app my-app mi-primer-app

cd mi-primer-app

npm start


#Referencias: https://es.reactjs.org/
# 

## Configuracion de GIT

git config --global user.name "frannkx"
git config --global user.email "frannkx@gmail.com"

git config --list

# crear llave SSH 
ssh-keygen -t rsa -b 4096 -C frannkx@gmail.com

eval "$(ssh-agent -s)"

#agregar llave privada al servidor ssh
ssh-add ~/.ssh/id_rsa

#agregar llave publica a github

sudo apt install xclip

#copiar al portapapaeles
xclip -selection clipboard < ~/.ssh/id_rsa.pub

#pegar contenido en administracion de llaves en github

a;adir origen remoto
git remote add origin urlxxx.git

git remote -v

git branch -M main
git push -u origin main


