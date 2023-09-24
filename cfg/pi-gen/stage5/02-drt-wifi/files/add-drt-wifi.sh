#!/bin/bash -e
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
  date >> /opt/drt-wifi/nonroot-calls
  echo "Not running as root. Aborting."
  exit
fi

# Determine directory holding this script.
DRT_WIFI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ $DRT_WIFI_DIR = *" "* ]]; then
  echo "There is a space in the base path of drt-wifi."
  echo "This is not supported."
  echo "Please remove the spaces, or move drt-wifi directory to a base path without spaces" 1>&2
  exit 1
fi

TARGET_FILE=/etc/wpa_supplicant/wpa_supplicant.conf
TMP_FILE=/tmp/drt-wpa_supplicant.conf

# Use current wpa_supplicant.conf as the starting point if present.
if [[ -f $TARGET_FILE ]]; then
  install -m 600 $TARGET_FILE $TMP_FILE
else
  install -m 600 $DRT_WIFI_DIR/wpa_supplicant_base.conf $TMP_FILE
fi

# Add country if missing.
COUNT=$(cat $TMP_FILE | grep "country=" | wc -l)
if [[ $COUNT -eq 0 ]] ; then
  cat $DRT_WIFI_DIR/wpa_supplicant_country.conf >> $TMP_FILE
fi

# Add section for each available SSID not configured yet.
for FP in $DRT_WIFI_DIR/*.ssid; do
  F=$(basename $FP)
  SSID=$(basename $FP .ssid)
  COUNT=$(cat $TMP_FILE | grep "ssid" | grep "$SSID" | wc -l)
  if [[ $COUNT -eq 0 ]] ; then
    cat $FP >> $TMP_FILE
  fi
done

# Put complete config in place.
install -m 600 $TMP_FILE $TARGET_FILE
rm $TMP_FILE

# Enable wifi.
rfkill unblock wifi
for filename in /var/lib/systemd/rfkill/*:wlan ; do
  echo 0 > $filename
done

# Disable service after first run.
systemctl disable add-drt-wifi

