#!/bin/bash
for host in `cat Hostdetail.txt` ; do puppet kick --host $host --ping; done
