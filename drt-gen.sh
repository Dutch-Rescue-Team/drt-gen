#!/bin/bash -e
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root. Aborting."
    exit
fi

# Determine location directory holding this script and related directories.
SRC_ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ $SRC_ROOT_DIR = *" "* ]]; then
	echo "There is a space in the base path of drt-gen"
	echo "This is not supported."
	echo "Please remove the spaces, or move drt-gen directory to a base path without spaces" 1>&2
	exit 1
fi
echo SRC_ROOT_DIR $SRC_ROOT_DIR
SRC_CFG_DIR=$SRC_ROOT_DIR/cfg

# Set dtr-gen variables.
source $SRC_CFG_DIR/drt-gen.cfg

# Ensure DTR_IMG_DIR is not pointing to a file.
if [[ -f $DRT_IMG_DIR ]]; then
	echo "Configuration item DRT_IMG_DIR is pointing to a file."
	echo "This is not supported."
	echo "Please choose an existing folder or a folder that can be created." 1>&2
	exit 1
fi

# Ensure DTR_IMG_DIR directory exists.
mkdir -p $DRT_IMG_DIR

# Retrieve pi-gen code.
DEST_GEN_DIR=$DRT_IMG_DIR/pi-gen
if [[ -f $DEST_GEN_DIR ]]; then rm -f $DEST_GEN_DIR/; fi
if [[ -d $DEST_GEN_DIR ]]; then rm -r -f $DEST_GEN_DIR; fi
git clone $PI_GEN_GIT_REPO $DEST_GEN_DIR
cd $DEST_GEN_DIR
git checkout $PI_GEN_GIT_REPO_HASH

# Replace default stage definitions with drt-gen.
rm -r $DEST_GEN_DIR/stage*
cp -r $SRC_CFG_DIR/pi-gen/stage* $DEST_GEN_DIR

# Remove previous pi-gen work directory to ensure consistent results.
echo Start removing previous pi-gen work directory.
DEST_WORK_DIR=$DRT_IMG_DIR/work
if [[ -f $DEST_WORK_DIR ]]; then rm -f $DEST_WORK_DIR/; fi
if [[ -d $DEST_WORK_DIR ]]; then rm -r -f $DEST_WORK_DIR; fi
echo Done removing previous pi-gen work directory.

# Complete and copy config from template.
FIRST_USER_NAME=$(cat $KDBX_PWD_FILE | keepassxc-cli show -a username $KDBX_FILE "first user") 
FIRST_USER_PASS=$(cat $KDBX_PWD_FILE | keepassxc-cli show -a password $KDBX_FILE "first user")

cat > $DEST_GEN_DIR/config << EOF
DRT_IMG_DIR=$DRT_IMG_DIR
FIRST_USER_NAME=$FIRST_USER_NAME
FIRST_USER_PASS=$FIRST_USER_PASS
EOF

cat $SRC_CFG_DIR/pi-gen/config >> $DEST_GEN_DIR/config

# Complete and copy drt-wifi ssid files.
TARGET_WIFI_DIR=$DEST_GEN_DIR/stage5/02-drt-wifi/files
for FP in $SRC_CFG_DIR/drt-wifi/*.ssid; do
  echo Wifi file: $FP
  F=$(basename $FP)
  SSID=$(basename $FP .ssid)
  PSK=$(cat $KDBX_PWD_FILE | keepassxc-cli show -a password $KDBX_FILE "wifi: $SSID")
  sed "s/psk=/psk=$PSK/g" $FP > $TARGET_WIFI_DIR/$F
done

# Complete and copy vnc-server file.
SRC_VNC_FILE=$SRC_CFG_DIR/vnc-server/common.custom
TARGET_VNC_FILE=$DEST_GEN_DIR/stage5/06-vnc-server/files/common.custom
VNC_HASH=$(cat $KDBX_PWD_FILE | keepassxc-cli show -a password $KDBX_FILE "VNC Server - hash")
sed "s/Password=/Password=$VNC_HASH/g" $SRC_VNC_FILE > $TARGET_VNC_FILE

# Provide default hostname for user settings.
TARGET_USER_DIR=$DEST_GEN_DIR/stage5/00-drt-user/files
source $DEST_GEN_DIR/config
sed "s/DEFAULT_HOSTNAME=/DEFAULT_HOSTNAME=$TARGET_HOSTNAME/g" $SRC_CFG_DIR/drt-user/defaults.cfg > $TARGET_USER_DIR/defaults.cfg

# Log current pi-gen git status.
cd $DEST_GEN_DIR
TARGET_GIT_STATUS_FILE=$DEST_GEN_DIR/stage5/99-gen-meta/files/pi-gen_git_status.log
(
  echo "***"
  echo "* git last commit"
  echo "***"
  git log -n 1
  echo ""
  echo "***"
  echo "* git status -v -v"
  echo "***"
  git status -v -v
) > "$TARGET_GIT_STATUS_FILE"

# Log current drt-gen git status.
cd $SRC_ROOT_DIR
TARGET_GIT_STATUS_FILE=$DEST_GEN_DIR/stage5/99-gen-meta/files/drt-gen_git_status.log
(
  echo "***"
  echo "* git last commit"
  echo "***"
  git log -n 1
  echo ""
  echo "***"
  echo "* git status -v -v"
  echo "***"
  git status -v -v
) > "$TARGET_GIT_STATUS_FILE"

# Run pi-gen.
cd $DEST_GEN_DIR
./build.sh
