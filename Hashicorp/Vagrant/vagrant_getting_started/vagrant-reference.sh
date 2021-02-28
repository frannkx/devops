#Initialize directory of Vagrant.
vagrant init hashicorp/bionic64

#Start the virtual machine.
vagrant up

#Ingress in the virtual machine
vagrant ssh

#Destroy the virtual machine
vagrant destroy

#List box
vagrant box list

#Remove box
vagrant box remove hashicorp/bionic64

#Reload modification in the Vagrantfile
vagrant reload

#Install plugin to share box 
vagrant plugin install vagrant-share

#Share the environment
vagrant share

#Suspend the machine
vagrant suspend



#referencia 1 https://app.vagrantup.com/boxes/search


