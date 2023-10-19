#!/bin/bash -e

POLKIT_DIR="${ROOTFS_DIR}/etc/polkit-1/localauthority/50-local.d"
install -m 644 -t "${POLKIT_DIR}" files/45-allow-colord.pkla
install -m 644 -t "${POLKIT_DIR}" files/46-allow-update-repo.pkla
