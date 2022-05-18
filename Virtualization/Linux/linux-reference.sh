
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