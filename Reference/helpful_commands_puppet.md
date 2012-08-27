# References

## Facter

Listing the facts about the machine on which puppet will perform the application of the manifest.  Each of these commands can be used by referencing them with ${variableName} from within a manifest.

Command: `facter`

Output:

* architecture
* augeasversion
* boardmanufacturer
* boardproductname
* boardserialnumber
* domain
* facterversion
* fqdn
* hardwareisa
* hardwaremodel
* hostname
* id
* interfaces
* ipaddress
* ipaddress_eth0
* ipaddress_lo
* is_virtual
* kernel
* kernelmajversion
* kernelrelease
* kernelversion
* lsbdistcodename
* lsbdistdescription
* lsbdistid
* lsbdistrelease
* lsbmajdistrelease
* lsbrelease
* macaddress
* macaddress_eth0
* manufacturer
* memoryfree
* memorysize
* memorytotal
* netmask
* netmask_eth0
* netmask_lo
* network_eth0
* network_lo
* operatingsystem
* operatingsystemrelease
* osfamily
* path
* physicalprocessorcount
* processor0
* processorcount
* productname
* ps
* puppetversion
* rubysitedir
* rubyversion
* selinux
* serialnumber
* sshdsakey
* sshrsakey
* swapfree
* swapsize
* timezone
* type
* uniqueid
* uptime
* uptime_days
* uptime_hours
* uptime_seconds
* virtual

## Puppet Configuration

Printing the module path

Command: `puppet apply --configprint modulepath`

## Puppet Kick

## Puppet CA

## Puppet