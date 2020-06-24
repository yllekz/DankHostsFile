#!/bin/bash

#region Remove first:

echo $(date) #Command takes about 20 minutes to fully process
echo "Removing previous entries first..."
###Start of entry removals below:

#Purge existing Input table (keep the last 14 entries (12 entries + the two header lines), as those are placed there by default and we insert blocked entries before/above them)
#Harmless if the list is default (aka 14 lines)
blocked=`iptables -vnL INPUT --line-numbers | wc -l`
subtraction=$((blocked-14))

#Ranged for loops are screwy in busybox:
#https://microdevsys.com/wp/how-to-create-a-for-loop-to-print-a-sequence-or-range-of-numbers-on-dd-wrt-or-busybox-devices-linux/
#https://www.linuxquestions.org/questions/programming-9/print-1-to-100-in-a-shell-script-680052/
for i in `seq 1 $subtraction`;
    #do echo "Removal ${i} of ${subtraction}";
    do iptables -D INPUT 1; #Delete line 1 x amount of times
done;

#Purge existing Output table (harmless if the list is already blank)
iptables -F OUTPUT

#End of entry removals
#endregion

#region Now add entries:
echo $(date)
echo "Adding entries to iptables..."

#region Custom entries SK
iptables -I INPUT -s 42.48.244.41 -j logdrop #CN
iptables -I INPUT -s 42.48.0.0/15 -j logdrop #CN - entire range
iptables -I INPUT -s 54.37.87.65 -j logdrop #FR
iptables -I INPUT -s 54.36.0.0/16 -j logdrop #FR - entire range
iptables -I INPUT -s 45.141.153.162 -j logdrop #Minecraft vandals (US - NY)
iptables -I INPUT -s 185.209.177.52 -j logdrop #Minecraft vandals (US - LA)
iptables -I INPUT -s 173.49.229.128 -j logdrop #Minecraft vandals (US - VA)

iptables -I INPUT -s 146.88.240.4 -j logdrop #OpenVPN failed connection attempt (US - MI)
iptables -I INPUT -s 185.200.118.38 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.85 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.86 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.39 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.42 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.40 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.49 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.0/24 -j logdrop #OpenVPN failed connection attempt (UK - London - entire range)

iptables -I INPUT -s 220.134.36.88 -j logdrop #Caught in router sylogs (Taiwan)
iptables -I input -s 220.134.0.0/16 -j logdrop #Caught in router sylogs (Taiwan - entire range)
iptables -I INPUT -s 117.254.142.218 -j logdrop #Caught in router sylogs (India)
iptables -I INPUT -s 117.192.0.0/10 -j logdrop #Caught in router syslogs (India - entire range)
iptables -I INPUT -s 171.67.70.87 -j logdrop #Caught in router sylogs (US - CA)
iptables -I INPUT -s 85.99.245.103 -j logdrop #Caught in router sylogs (Turkey)
iptables -I INPUT -s 85.99.244.0/23 -j logdrop #Caught in router sylogs (Turkey - entire range)
iptables -I INPUT -s 37.49.224.19 -j logdrop #Caught in router sylogs (Netherlands)
iptables -I INPUT -s 37.49.224.0/24 -j logdrop #Caught in router sylogs (Netherlands - entire range)
iptables -I INPUT -s 123.19.44.5 -j logdrop #Caught in router sylogs (Vietnam)
iptables -I INPUT -s 123.16.0.0/12 -j logdrop #Caught in router sylogs (Vietnam - entire range)
iptables -I INPUT -s 84.0.154.20 -j logdrop #Caught in router sylogs (Hungary)
iptables -I INPUT -s 84.0.154.230 -j logdrop #Caught in router sylogs (Hungary)

#endregion

#ipsum list:
for ip in $(curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    #do echo $ip; done #Confirm first
    do iptables -I INPUT -s $ip -j DROP;
done;

echo $(date)

###End of entry additions
#endregion

####Display for confirmation:
#iptables -vnL INPUT --line-numbers
#iptables -vnL OUTPUT --line-numbers
#iptables -vnL INPUT --line-number | sort -r -g -k 2 | more