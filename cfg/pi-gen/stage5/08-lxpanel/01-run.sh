#!/bin/bash -e

USR_CFG_DIR="${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.config"
USR_CFG_LXDE_DIR="${USR_CFG_DIR}/lxpanel/LXDE-pi"
USR_CFG_PANELS_DIR="${USR_CFG_LXDE_DIR}/panels"
install -v -m 755 -D -d "$USR_CFG_PANELS_DIR"
install -v -m 644 -t "$USR_CFG_LXDE_DIR" files/lxpanel/LXDE-pi/config
install -v -m 644 -t "$USR_CFG_PANELS_DIR" files/lxpanel/LXDE-pi/panels/panel
chown -R 1000:1000 "${USR_CFG_DIR}"
