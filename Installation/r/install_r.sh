#!/bin/bash
# Install R on HDP
# Author: Paul Codding <paul@hortonworks.com>
# IMPORTANT: Please make sure you update the path to the .tar.gz files 
# referenced below to the actual path on your cluster!
export RMR_PATH=/root/hdp/r/rmr_1.3.1.tar.gz
export RHDFS_PATH=/root/hdp/r/rhdfs_1.0.5.tar.gz
export RHBASE_PATH=/root/hdp/r/rhbase_1.0.4.tar.gz

if [ -f $RMR_PATH ] && [ -f $RHDFS_PATH ] && [ -f $RHBASE_PATH ] && [ -f /usr/lib/hadoop/bin/hadoop-config.sh ] && [ ! -f /usr/bin/R ]; then 
	echo "Installing R"
else
	echo "Please install HDP and download rmr, rhdfs, rhbase and make sure R is not already installed.  If you've already downloaded those projects and R is not installed check the *_PATH variables in this script"
	exit 1
fi

# Setup the required R environmental variables for interacting with Hadoop
cat > /etc/profile.d/r.sh <<END
. /usr/lib/hadoop/bin/hadoop-config.sh --config /etc/hadoop/conf
export HADOOP_CMD=/usr/bin/hadoop
export HADOOP_STREAMING=/usr/lib/hadoop/contrib/streaming/hadoop-streaming-1.0.3.15.jar
END

# Source the profile
. /etc/profile.d/r.sh

# Install R from epel
yum -y install R

# Validate R
R --version | grep "2.15.1"

# Install projects and their dependencies
if [ $? -eq 0 ]; then
	echo 'options(repos=structure(c(CRAN="http://cran.stat.ucla.edu")))' >> /root/.Rprofile
	Rscript -e 'install.packages("RJSONIO");'
	if [ $? -eq 0 ]; then
		Rscript -e 'install.packages("itertools");'
		if [ $? -eq 0 ]; then
			Rscript -e 'install.packages("digest");'
			if [ $? -eq 0 ]; then
				Rscript -e 'install.packages("Rcpp");'
				if [ $? -eq 0 ]; then
					R CMD INSTALL rmr $RMR_PATH
					R CMD javareconf
					Rscript -e 'install.packages("rJava");'
					if [ $? -eq 0 ]; then
						R CMD INSTALL rhdfs $RHDFS_PATH
					fi
					#R CMD INSTALL rhbase $RHBASE_PATH
				fi
			fi
		fi
	fi
fi