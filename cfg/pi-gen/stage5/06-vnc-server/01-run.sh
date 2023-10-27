#!/bin/bash -e

VNC_CFG_DIR="${ROOTFS_DIR}/etc/vnc/config.d"
install -v -m 600 -t "${VNC_CFG_DIR}" files/common.custom
