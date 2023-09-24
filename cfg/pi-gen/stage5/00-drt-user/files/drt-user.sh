#!/bin/bash -e
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  echo "Not running as root. Aborting."
  exit
fi

LOGFILE=/opt/drt-user/test.log
date >> $LOGFILE

# -- Determine directory holding this script.
SRC_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ $SRC_ROOT_DIR = *" "* ]]; then
  echo "There is a space in the base path of drt-user."
  echo "This is not supported."
  echo "Please remove the spaces, or move drt-user directory to a base path without spaces" 1>&2
  exit 1
fi

# -- Default values
source $SRC_ROOT_DIR/defaults.cfg

# -- Check ids
RPI_ID=$($SRC_ROOT_DIR/rpi-id.sh)
ROOTFS_CID=$($SRC_ROOT_DIR/rootfs-cid.sh)
echo RPI_ID: $RPI_ID
echo ROOTFS_CID: $ROOTFS_CID

# grep -rnw . -e ^10000000e40cae90:

# -- Hostname
CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
echo CURRENT_HOSTNAME: $CURRENT_HOSTNAME

# echo mijnbot >/etc/hostname
# sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\tmijnbot/g" /etc/hosts

# -- Username


# -- Authorized keys - NOTE: Temporary a public key is also configured in pi-gen/config



# -- Disable service after first run and reboot.
# systemctl disable add-drt-wifi
# systemctl start reboot.target

