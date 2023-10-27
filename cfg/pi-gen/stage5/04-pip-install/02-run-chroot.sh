#!/bin/bash -e

pip install python_json_config

# pip install pupil-apriltags==1.0.4
# Installing pupil-apriltags==1.0.4 using pip fails. So, a workaround.
WHEEL_FILE=pupil_apriltags-1.0.4-cp39-cp39-linux_armv7l.whl
SOURCE=https://www.piwheels.org/simple/pupil-apriltags/$WHEEL_FILE
TARGET=/tmp/$WHEEL_FILE
wget --quiet --tries=2 -O $TARGET $SOURCE
unzip -d /usr/local/lib/python3.9/dist-packages $TARGET
echo APRILTAGS unzipped
rm $TARGET
