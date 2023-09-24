#!/bin/bash -e

install -m 644 files/drt-user.service "${ROOTFS_DIR}/lib/systemd/system/drt-user.service"
DRT_USER_DIR="${ROOTFS_DIR}/opt/drt-user"
install -m 755 -d "${DRT_USER_DIR}"
install -m 755 -t "${DRT_USER_DIR}" files/*.sh
for FP in files/*.user; do
  F=$(basename $FP)
  install -m 755 -d "${DRT_USER_DIR}/$F"
  install -m 644 -t "${DRT_USER_DIR}/$F" $FP/*
done
install -m 644 -t "${DRT_USER_DIR}" files/*.cfg

