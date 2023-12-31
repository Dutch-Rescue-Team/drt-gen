#!/bin/bash -e

# drt default log location
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/log"

# drt default location for git clones
install -v -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src"

# drt folder in path used for drt scripts
BIN_DIR="${ROOTFS_DIR}/home/${FIRST_USER_NAME}/bin"
install -v -o 1000 -g 1000 -d "${BIN_DIR}"
install -v -o 1000 -g 1000 -m 755 -t "${BIN_DIR}" files/rtc

# drt shell environment variables: PYTHONPATH DrtConfigRoot DrtLogRoot
install -v -o 1000 -g 1000 -m 644 files/.drt-env "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.drt-env"
echo "[[ -f ~/.drt-env ]] && source ~/.drt-env" >> "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.bashrc"
echo "[[ -f \$HOME/.drt-env ]] && source \$HOME/.drt-env" >> "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.profile"

# support VS Code remote
install -v -t "${ROOTFS_DIR}/etc/ssh/sshd_config.d" files/ssh-drt.conf
