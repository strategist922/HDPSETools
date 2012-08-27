#!/bin/bash
TPUT='tput -T xterm-color'
txtund=$(${TPUT} sgr 0 1)          # Underline
txtbld=$(${TPUT} bold)             # Bold
txtrst=$(${TPUT} sgr0)             # Reset

for host in `cat Hostdetail.txt`; do
  echo -e "${txtbld}\n######################################################"
  echo -e "# Copying $1 to Path: $2 on Host: $host"
  echo "######################################################${txtrst}"
  scp $i root@$host:$2
done