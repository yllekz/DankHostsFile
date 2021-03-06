#!/bin/bash

#At the moment this script assumes that you have freshly rebooted your DD-WRT router.
#Right now this script will NOT properly refresh an already-modified hosts file.
#We also assume /tmp/hosts is blank except for the default entries that are automatically added.

#region pull hosts and append to hosts file:

temphosts=/tmp/root/hosts.txt
prodhosts=/tmp/hosts
hostsbackup /tmp/root/hosts-bak

#This is a work in progress to attempt to clear out the ...
#while read line; do if [ "$line" = "10.*" ]; then echo "$line"; else; fi; done < $prodhosts;
#while read line; do if [ "$line" = "10.*" ]; then echo "$line" >> $prodhosts; else; fi; done < $prodhosts;

#Take the existing hosts file and move it out of play
#mv $prodhosts $hostsbackup

wget -O $temphosts https://raw.githubusercontent.com/yllekz/DankHostsFile/master/hosts;
while read line; do echo "$line" >> $prodhosts; done < $temphosts;
killall -HUP dnsmasq;

#endregion