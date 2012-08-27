# SE Tool Command examples

## Run Command

Disable SELinux on all nodes

`./run_command.sh 'hostname -f'`

## Copy file

`./copy_file.sh /etc/selinux/config /etc/selinux`

## Distribute SSH Keys

`./distribute_ssh_keys.sh /root/.ssh/id_dsa.pub`