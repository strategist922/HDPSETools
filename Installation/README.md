# Downloading from client machine

* wget --no-check-certificate https://github.com/pcodding/HDPSETools/zipball/master -O tools.zip
* unzip tools.zip
* mv pc\*/Installation/\*.sh .
* chmod u+x *.sh

# SE Tool Command examples

## Run Command

Disable SELinux on all nodes

`./run_command.sh 'hostname -f'`

## Copy file

`./copy_file.sh /etc/selinux/config /etc/selinux`

## Distribute SSH Keys

`./distribute_ssh_keys.sh /root/.ssh/id_dsa.pub`