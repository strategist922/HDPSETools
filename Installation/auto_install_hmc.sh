# Prep Cluster
OS_VERSION=`cat /etc/redhat-release | egrep -o '[0-9]' | head -1`
if [ ! -d /root/hdp ]; then	
	echo " Taking care of pre-reqs"
	mkdir /root/hdp
	mount | egrep 'xvd[a-z]\W' | awk '{print $1 "\t" $3 "    ext3    defaults        0 0";}' >> /etc/fstab
	cat /etc/fstab
	read -p "Continue? [press a key]"
	cat /etc/selinux/config | sed 's/SELINUX=enforcing/SELINUX=disabled/' > t
	mv t /etc/selinux/config
	cat /etc/selinux/config
	read -p "Continue? [press a key]"
	cd /root/hdp
	read -p "I'm going to need a list of hosts, please come up with the list, then press ENTER"
	vi Hostdetail.txt
	wget --no-check-certificate https://github.com/pcodding/HDPSETools/zipball/master -O tools.zip
	unzip tools.zip
	mv pc*/Installation/*.sh .
	chmod u+x *.sh
	rm -f tools.zip
	rm -rf pc*
	ssh-keygen
	./distribute_ssh_keys.sh /root/.ssh/id_rsa.pub
	./run_command.sh 'cat /etc/fstab'
	./copy_file.sh /etc/fstab /etc
	./copy_file.sh /etc/selinux/config /etc/selinux/
	./run_command.sh 'chkconfig --del iptables'
	./run_command.sh 'service iptables stop'
	./run_command.sh 'iptables -vnL'
	./run_command.sh 'yum -y erase mysql-libs'
	./run_command.sh 'yum -y install net-snmp net-snmp-utils'
	./run_command.sh 'yum -y install ntp'
	read -p " I'm going to reboot all of these servers, is that ok? [y/n] " REBOOT
	if [ $REBOOT == "y" ]; then
		./run_command.sh 'reboot'
	else
		echo " Ok, run me again and I'll do the HMC install"
	fi
else
	echo " Installing HDP"
	cd /root/hdp
	./run_command.sh 'service ntpd start'
	./pre_install_check.sh > out
	if [ $OS_VERSION -eq 5 ]; then
		rpm -Uvh http://public-repo-1.hortonworks.com/HDP-1.1.1.16/repos/centos5/hdp-release-1.1.1.16-1.el5.noarch.rpm
		yum -y install epel-release
		yum -y install php-pecl-json
	else
		rpm -Uvh http://public-repo-1.hortonworks.com/HDP-1.1.0.15/repos/centos6/hdp-release-1.1.0.15-1.el6.noarch.rpm
		yum -y install epel-release
	fi
	yum -y install hmc
	service hmc start
fi