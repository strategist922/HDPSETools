#!/bin/bash
# 
#  pre_install_check.sh
#  Hortonworks SE Tools
#  
#  Created by Paul Codding on 2012-08-08.
#  
#  This script is used to run a quick check before building out a cluster to allow the user to check to ensure all pre-reqs have been met
#

SSHKEY=/tmp/ec2-keypair.pem
for host in `cat Hostdetail.txt`; do
  echo -e "\n######################################################"
  echo -e "# Checking Host: $host"
  echo "######################################################"
  ssh -i $SSHKEY root@$host PREREQS=$PREREQS 'bash -s' << 'END'
  PREREQS=( yum rpm ssh curl wget net-snmp net-snmp-utils )
  POSSIBLE_CONFLICTS=( ruby puppet nagios mysql ganglia passenger )
  echo -e "[*] Checking base system requirements for host $host"
  echo -e "\n[**] Checking Processors"
  cat /proc/cpuinfo  | grep 'model name' | awk -F': ' '{ print $2; }'
  echo -e "\n[**] Checking RAM"
  cat /proc/meminfo  | grep MemTotal | awk '{ print $2/1024/1024 " GB"; }'
  echo -e "\n[**] Checking disk space"
  df -h
  echo -e "\n[**] Checking OS and arch"
  cat /etc/issue.net | head -1 
  arch
  echo -e "\n[**] Checking host files"
  cat /etc/hosts
  echo -e "\n[**] Checking iptables"
  iptables -vnL
  echo -e "\n[**] Checking SELinux configuration"
  cat /etc/selinux/config | grep ^SELINUX
  echo -e "\n[**] Checking prereq packages"
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