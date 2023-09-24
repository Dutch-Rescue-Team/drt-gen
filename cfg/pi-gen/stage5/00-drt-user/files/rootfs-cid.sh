#!/bin/bash

disks=`lsblk -d -n -l | cut -d" " -f1`
rootfs=`mount -l | grep rootfs]$ | cut -d" " -f1 | cut -d/ -f3`
bootdisk=`for d in $disks ; do echo $rootfs | grep $d | xargs -i echo $d ; done`
# echo bootdisk: $bootdisk
cid=/sys/block/$bootdisk/device/cid
cat $cid
