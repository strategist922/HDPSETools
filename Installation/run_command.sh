#!/bin/bash
TPUT='tput -T xterm-color'
txtund=$(${TPUT} sgr 0 1)          # Underline
txtbld=$(${TPUT} bold)             # Bold
txtrst=$(${TPUT} sgr0)             # Reset

for host in `cat Hostdetail.txt`; do
  echo -e "${txtbld}\n######################################################"
  echo -e "# Running command $1 on Host: $host"
  echo "######################################################${txtrst}"
  ssh root@$host COMMAND="'$1'" 'bash -s' << 'END'
	$COMMAND
END
done