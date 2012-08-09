#!/bin/bash
SSHKEY=/tmp/ec2-keypair.pem
TPUT='tput -T xterm-color'
txtund=$(${TPUT} sgr 0 1)          # Underline
txtbld=$(${TPUT} bold)             # Bold
txtrst=$(${TPUT} sgr0)             # Reset

for host in `cat Hostdetail.txt`; do
  echo -e "${txtbld}\n######################################################"
  echo -e "# Checking Host: $host"
  echo "######################################################${txtrst}"
  ssh -i $SSHKEY root@$host 'bash -s' << 'END'
  function printHeading() {
    echo -e "\n${txtund}[*] $1 \n######################################################${txtrst}"
  }
  PREREQS=( yum rpm ssh curl wget net-snmp net-snmp-utils ntpd )
  POSSIBLE_CONFLICTS=( ruby puppet nagios mysql ganglia passenger cloudera hadoop )
  printHeading "Checking Processors"
  cat /proc/cpuinfo  | grep 'model name' | awk -F': ' '{ print $2; }'
  printHeading "Checking RAM"
  cat /proc/meminfo  | grep MemTotal | awk '{ print $2/1024/1024 " GB"; }'
  printHeading "Checking disk space"
  df -h
  printHeading "Checking OS and arch"
  cat /etc/issue.net | head -1 
  arch
  printHeading "Checking host files"
  cat /etc/hosts
  printHeading "Checking hostname"
  echo "hostname -f: `hostname -f`" 
  echo "hostname -i: `hostname -i`"
  printHeading "Checking iptables"
  iptables -vnL
  printHeading "Checking SELinux configuration"
  cat /etc/selinux/config | grep ^SELINUX
  printHeading "Checking prereq packages"
  RPMS=`rpm -qa`
  for package in ${PREREQS[@]}; do
    echo -n "Looking for: $package - "
    echo $RPMS | grep $package > /dev/null
    if [ $? -eq 0 ]; then echo "found";  else echo "NOT FOUND!";  fi
  done
  for package in ${POSSIBLE_CONFLICTS[@]}; do
    echo -n "Looking for posible conflicting package: $package - "
    echo $RPMS | grep $package > /dev/null
    if [ $? -eq 0 ]; then echo "FOUND! `rpm -qa | grep $package`" ; else echo "not installed"; fi
  done
END
done