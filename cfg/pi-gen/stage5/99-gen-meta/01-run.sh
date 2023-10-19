#!/bin/bash -e

DRT_GEN_LOG="${ROOTFS_DIR}/var/log/drt-gen"
install -d "${DRT_GEN_LOG}"

# Git status log files are generated in drt-gen.sh
install -m 644 -t "${DRT_GEN_LOG}" "files/drt-gen_git_status.log"
install -m 644 -t "${DRT_GEN_LOG}" "files/pi-gen_git_status.log"
