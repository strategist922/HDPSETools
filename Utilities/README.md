# General Utilities

Contains general utilities for working with HDP or EC2.

## EC2 Utilities

Because I don't want to type `ssh -i /path/to/keypair.pem hostname` every time I need to access an EC2 instance, I've created these scripts to simplify the process:

* ec2 - This utility is used to SSH into an ec2 instance by just specifying the hostname e.g. `ec2 hostname`
* ec2cp - This utility is used to SCP files to/from an ec2 instance e.g. `ec2cp /tmp/file hostname@/tmp`
* ec2sftp - This utility is used to SFTP files to/from an ec2 instance e.g. `ec2sftp hostname`

### Setup

Download the scripts including the `config.sh`.  Edit the `config.sh` with the path to your EC2 keypair, then but the scripts in your `PATH`.  I place my scripts in `~/scripts`.