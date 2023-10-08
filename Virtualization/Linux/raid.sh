#/bin/bash

lsblk


NAME      MAJ:MIN RM SIZE RO TYPE MOUNTPOINTS
xvda      202:0    0   8G  0 disk
├─xvda1   202:1    0   8G  0 part /
├─xvda127 259:0    0   1M  0 part
└─xvda128 259:1    0  10M  0 part /boot/efi
xvdf      202:80   0  50G  0 disk
xvdg      202:96   0  50G  0 disk

sudo yum install mdadm

sudo mdadm --create --verbose /dev/md0 --level=0 --name=MY_RAID --raid-devices=number_of_volumes device_name1 device_name2

sudo mdadm --create --verbose /dev/md0 --level=0 --name=mi-test-raid --raid-devices=2 /dev/xvdf /dev/xvdg

sudo mdadm --create --verbose /dev/md0 --level=5 --name=mi-test-raid --raid-devices=4 /dev/xvdb /dev/xvdc /dev/xvdd /dev/xvde

sudo cat /proc/mdstat

Personalities : [raid0]
md0 : active raid0 xvdg[1] xvdf[0]
      104790016 blocks super 1.2 512k chunks


/dev/md0:
           Version : 1.2
     Creation Time : Mon Oct  2 06:54:43 2023
        Raid Level : raid0
        Array Size : 104790016 (99.94 GiB 107.30 GB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Mon Oct  2 06:54:43 2023
             State : clean
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

            Layout : -unknown-
        Chunk Size : 512K

Consistency Policy : none

              Name : mi-test-raid
              UUID : 68604f37:0998df4f:79796b55:712071e4
            Events : 0

    Number   Major   Minor   RaidDevice State
       0     202       80        0      active sync   /dev/sdf
       1     202       96        1      active sync   /dev/sdg


sudo mkfs.xfs -L MI_RAID /dev/md0

log stripe unit (524288 bytes) is too large (maximum is 256KiB)
log stripe unit adjusted to 32KiB
meta-data=/dev/md0               isize=512    agcount=16, agsize=1637248 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1
data     =                       bsize=4096   blocks=26195968, imaxpct=25
         =                       sunit=128    swidth=256 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=8 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf

ARRAY /dev/md0 metadata=1.2 name=mi-test-raid UUID=68604f37:0998df4f:79796b55:712071e4

sudo dracut -H -f /boot/initramfs-$(uname -r).img $(uname -r)

sudo mkdir -p /mnt/raid

sudo mount LABEL=MI_RAID /mnt/raid

sudo cp /etc/fstab /etc/fstab.orig

vi /etc/fstab

LABEL=MI_RAID       /mnt/raid   xfs    defaults,nofail        0       2

sudo mount -a

#Restaurar fstab
sudo mv /etc/fstab.orig /etc/fstab

#Create a big file and generate checksum
sudo fallocate -l 10G bigfile
sudo md5sum bigfile >> bigfile.md5sum

#Validate integrity of file 
cksum bigfile
md5sum archivo
sha256sum archivo

cksum
1664382818 32212254720 bigfile

md5sum
b5622c6c6fc5ab85712dc2a08c9e55d3  bigfile

sha256sum
977bf5033165994e1d6837b65d66ac29093bfcfb1e49b4b828387b35cc830673  bigfile


#Add disk in RAID
sudo fdisk /dev/sdX #n , primary, linux raid autodetect, w
mdadm --add /dev/md0 /dev/sdX

#Remove disk in RAID
mdadm --remove /dev/md0 /dev/sdX 

#Testing disk fail and reconstruction
sudo mdadm --manage --fail /dev/md0 /dev/adX
sudo mdadm --detail /dev/md0

#References:
#https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/raid-config.html
#https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/ebs-attaching-volume.html
#https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/ebs-using-volumes.html
#https://www.profesionalreview.com/2019/01/24/tecnologia-raid/
#https://www.vozidea.com/crear-archivo-grande-en-linux-rapido#:~:text=En%20funci%C3%B3n%20del%20comando%20elegido%2C%20tendr%C3%ADamos%20los%20siguientes,de%201GB%3A%20sudo%20dd%20if%3D%2Fdev%2Fzero%20of%3D%2Farchivogrande%20bs%3D1024%20count%3D1024k
#https://www.youtube.com/watch?v=I4XskrVF3Xo
#https://www.enmimaquinafunciona.com/pregunta/21866/recuperar-raid-5-que-ya-funcionaba-en-modo-degradado-perdio-un-segundo-disco

