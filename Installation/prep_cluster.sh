# Prep Cluster
cd /root
mkdir hdp && cd hdp
vi Hostdetail.txt
wget --no-check-certificate https://github.com/pcodding/HDPSETools/zipball/master -O tools.zip
unzip tools.zip
mv pc*/Installation/*.sh .
chmod u+x *.sh
rm -f tools.zip
rm -rf pc*
ssh-keygen
./distribute_ssh_keys.sh /root/.ssh/id_rsa.pub
vi /etc/fstab
vi /etc/selinux/config
./run_command.sh 'cat /etc/fstab'
./copy_file.sh /etc/fstab /etc
./copy_file.sh /etc/selinux/config /etc/selinux/
./run_command.sh 'chkconfig --del iptables'
./run_command.sh 'service iptables stop'
./run_command.sh 'iptables -vnL'
./run_command.sh 'yum -y erase mysql-libs'
./run_command.sh 'yum -y install net-snmp net-snmp-utils ntpd'
./run_command.sh 'reboot'
./run_command.sh 'service ntpd start'
cd /root/hdp && ./pre_install_check.sh > out
# rpm -Uvh http://public-repo-1.hortonworks.com/HDP-1.1.0.15/repos/centos6/hdp-release-1.1.0.15-1.el6.noarch.rpm
# yum install epel-release
# yum install hmc
# service hmc start