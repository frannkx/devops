#!/bin/bash

#### Disk management guide ####

#Show disks
sudo fdisk -l

#Show block devices
sudo lsblk

#Show partitions
sudo cat /proc/partitions

#Show disk space usage
sudo df -h

#Show disk array Raid
sudo cat /proc/mdstat


#Build filesystem
mkfs.[type]

#Build partition
fdisk /dev/sdx 
n
num partition type

#kernel detect changes on partitions table 
sudo partprobe


#repit command every time
sudo watch -n1 [command]





