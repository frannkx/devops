vboxmanage list -s vms

vboxmanage list -s runningvms

vboxmanage startvm Win10 --type headless

VBoxManage modifyhd “C:\Users\Chris\VirtualBox VMs\Windows 7\Windows 7.vdi”

VBoxManage modifymedium disk “C:\Users\Chris\VirtualBox VMs\Windows 7\Windows 7.vdi” --resize 81920

VBoxManage.exe startvm 55f3c2b2-e830-431c-85c5-5269cafeab7e --type headless

#https://www.howtogeek.com/124622/how-to-enlarge-a-virtual-machines-disk-in-virtualbox-or-vmware/


#https://www.virtualbox.org/manual/ch08.html

C:\Users\vagrant> cd C:\TestDir\vagrant-project
C:\TestDir\vagrant-project> bash
vagrant@vagrant-10:/mnt/c/TestDir/vagrant-project$ export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/TestDir"
vagrant@vagrant-10:/mnt/c/TestDir/vagrant-project$ vagrant ssh
