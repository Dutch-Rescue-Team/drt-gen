#!/bin/bash -e

POLKIT_LA_DIR="${ROOTFS_DIR}/etc/polkit-1/localauthority"
POLKIT_DIR="${POLKIT_LA_DIR}/55-drt.d"
chmod 755 "${POLKIT_LA_DIR}"
install -v -m 755 -d "${POLKIT_DIR}"
install -v -m 644 -t "${POLKIT_DIR}" files/*.pkla
