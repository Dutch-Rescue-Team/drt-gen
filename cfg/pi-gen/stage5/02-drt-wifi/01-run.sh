#!/bin/bash -e

install -m 644 files/add-drt-wifi.service "${ROOTFS_DIR}/lib/systemd/system/add-drt-wifi.service"
DRT_WIFI_DIR="${ROOTFS_DIR}/opt/drt-wifi"
install -d "${DRT_WIFI_DIR}"
install -m 755 files/add-drt-wifi.sh "${DRT_WIFI_DIR}/add-drt-wifi.sh"
install -m 600 -t "${DRT_WIFI_DIR}" files/wpa_supplicant_base.conf
install -m 600 -t "${DRT_WIFI_DIR}" files/*.ssid

