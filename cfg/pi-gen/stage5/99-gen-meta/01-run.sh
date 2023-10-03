#!/bin/bash -e

DRT_GEN_LOG="${ROOTFS_DIR}/var/log/drt-gen"
install -d "${DRT_GEN_LOG}"

# drt-gen_git_status.log is generated in drt-gen.sh
install -m 644  "$WORK_DIR/drt-gen_git_status.log" "${DRT_GEN_LOG}/drt-gen_git_status.log"

