#!/bin/bash
TPUT='tput -T xterm-color'
txtund=$(${TPUT} sgr 0 1)          # Underline
txtbld=$(${TPUT} bold)             # Bold
txtrst=$(${TPUT} sgr0)             # Reset
if [ $# -ne 2 ]; then
	echo "Plase specify the file to copy and the file path to copy it to."
else
	for host in `cat Hostdetail.txt`; do
	  echo -e "${txtbld}\n######################################################"
	  echo -e "# Copying $1 to Path: $2 on Host: $host"
	  echo "######################################################${txtrst}"
	  scp $1 root@$host:$2
	done
fi