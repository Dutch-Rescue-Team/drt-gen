#!/bin/bash -e

DRT_GEN_LOG="/var/log/drt-gen"
install -d "${DRT_GEN_LOG}"

apt-mark showmanual > "${DRT_GEN_LOG}/apt_manual" 
apt-mark showauto > "${DRT_GEN_LOG}/apt_auto"
dpkg-query -l > "${DRT_GEN_LOG}/pkg_query"
pip list > "${DRT_GEN_LOG}/pip_list"
pip freeze > "${DRT_GEN_LOG}/pip_freeze"

