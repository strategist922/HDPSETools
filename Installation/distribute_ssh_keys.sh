#!/bin/bash
TPUT='tput -T xterm-color'
txtund=$(${TPUT} sgr 0 1)          # Underline
txtbld=$(${TPUT} bold)             # Bold
txtrst=$(${TPUT} sgr0)             # Reset

for host in `cat Hostdetail.txt`; do
  echo -e "${txtbld}\n######################################################"
  echo -e "# Copying Key: $1 to Host: $host"
  echo "######################################################${txtrst}"
  ssh -i $SSHKEY root@$host 'bash -s' << 'END'
	mkdir ~/.ssh
END
  cat $i | ssh root @$host  'cat >> ~/.ssh/authorized_keys'
done