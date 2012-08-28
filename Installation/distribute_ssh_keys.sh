#!/bin/bash
TPUT='tput -T xterm-color'
txtund=$(${TPUT} sgr 0 1)          # Underline
txtbld=$(${TPUT} bold)             # Bold
txtrst=$(${TPUT} sgr0)             # Reset
if [ $# -ne 1 ] ; then
	echo "Please provide the path to the public ssh key as the argument!"
else
	for host in `cat Hostdetail.txt`; do
	  echo -e "${txtbld}\n######################################################"
	  echo -e "# Copying Key: $1 to Host: $host"
	  echo "######################################################${txtrst}"
	  ssh root@$host 'bash -s' << 'END'
	    if [ ! -d ~/.ssh ]; then
		mkdir ~/.ssh
	    fi
END
	  cat $1| ssh root@$host 'cat >> ~/.ssh/authorized_keys'
	done
fi