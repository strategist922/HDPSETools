# Helpful Commands - HMC

## Install Logs

### HMC Node

	tail -f /var/log/hmc/hmc.log /var/log/puppet*

### Cluster nodes
	
	tail -f /var/log/puppet*

## Dry Run

Edit `/usr/share/hmc/php/conf/Config.inc` and set `$GLOBALS["DRYRUN"] = FALSE;` to `TRUE`.  Restart HMC and it will be in dry run mode.
