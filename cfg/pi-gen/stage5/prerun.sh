#!/bin/bash -e

if [[ -f "${ROOTFS_DIR}" ]]; then rm "${ROOTFS_DIR}"; fi
if [[ -d "${ROOTFS_DIR}" ]]; then rm -r "${ROOTFS_DIR}"; fi
copy_previous

