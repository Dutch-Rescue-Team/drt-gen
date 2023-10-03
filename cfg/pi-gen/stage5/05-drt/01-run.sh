#!/bin/bash -e

install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/log"
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src" # Used to host git clones.

install -v -o 1000 -g 1000 -m 644 files/.drt-env "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.drt-env"
echo "[[ -f ~/.drt-env ]] && source ~/.drt-env" >> "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc"
echo "[[ -f \$HOME/.drt-env ]] && source \$HOME/.drt-env" >> "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.profile"

install files/ssh-drt.conf "${ROOTFS_DIR}/etc/ssh/sshd_config.d/ssh-drt.conf"

