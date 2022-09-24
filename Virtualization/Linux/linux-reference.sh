
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