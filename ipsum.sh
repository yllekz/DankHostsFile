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
iptables -I FORWARD -s 42.48.244.41 -j logdrop #CN
iptables -I FORWARD -s 42.48.0.0/15 -j logdrop #CN - entire range
iptables -I FORWARD -s 54.37.87.65 -j logdrop #FR
iptables -I FORWARD -s 54.36.0.0/16 -j logdrop #FR - entire range

iptables -I INPUT -s 45.141.153.162 -j logdrop #Minecraft vandals (US - NY)
iptables -I INPUT -s 185.209.177.52 -j logdrop #Minecraft vandals (US - LA)
iptables -I INPUT -s 173.49.229.128 -j logdrop #Minecraft vandals (US - VA)
iptables -I FORWARD -s 45.141.153.162 -j logdrop #Minecraft vandals (US - NY)
iptables -I FORWARD -s 185.209.177.52 -j logdrop #Minecraft vandals (US - LA)
iptables -I FORWARD -s 173.49.229.128 -j logdrop #Minecraft vandals (US - VA)

iptables -I INPUT -s 146.88.240.4 -j logdrop #OpenVPN failed connection attempt (US - MI)
iptables -I INPUT -s 185.200.118.38 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.85 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.86 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.39 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.42 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.40 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.49 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I INPUT -s 185.200.118.0/24 -j logdrop #OpenVPN failed connection attempt (UK - London - entire range)
iptables -I INPUT -s 192.35.169.27 -j logdrop #OpenVPN failed connection attempt (US - MI)
iptables -I INPUT -s 192.35.168.199 -j logdrop #OpenVPN failed connection attempt (US - MI)
iptables -I FORWARD -s 146.88.240.4 -j logdrop #OpenVPN failed connection attempt (US - MI)
iptables -I FORWARD -s 185.200.118.38 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.85 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.86 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.39 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.42 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.40 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.49 -j logdrop #OpenVPN failed connection attempt (UK - London)
iptables -I FORWARD -s 185.200.118.0/24 -j logdrop #OpenVPN failed connection attempt (UK - London - entire range)
iptables -I FORWARD -s 192.35.169.27 -j logdrop #OpenVPN failed connection attempt (US - MI)
iptables -I FORWARD -s 192.35.168.199 -j logdrop #OpenVPN failed connection attempt (US - MI)


iptables -I INPUT -s 220.134.36.88 -j logdrop #Caught in router sylogs (Taiwan)
iptables -I INPUT -s 220.134.0.0/16 -j logdrop #Caught in router sylogs (Taiwan - entire range)
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
iptables -I FORWARD -s 220.134.36.88 -j logdrop #Caught in router sylogs (Taiwan)
iptables -I FORWARD -s 220.134.0.0/16 -j logdrop #Caught in router sylogs (Taiwan - entire range)
iptables -I FORWARD -s 117.254.142.218 -j logdrop #Caught in router sylogs (India)
iptables -I FORWARD -s 117.192.0.0/10 -j logdrop #Caught in router syslogs (India - entire range)
iptables -I FORWARD -s 171.67.70.87 -j logdrop #Caught in router sylogs (US - CA)
iptables -I FORWARD -s 85.99.245.103 -j logdrop #Caught in router sylogs (Turkey)
iptables -I FORWARD -s 85.99.244.0/23 -j logdrop #Caught in router sylogs (Turkey - entire range)
iptables -I FORWARD -s 37.49.224.19 -j logdrop #Caught in router sylogs (Netherlands)
iptables -I FORWARD -s 37.49.224.0/24 -j logdrop #Caught in router sylogs (Netherlands - entire range)
iptables -I FORWARD -s 123.19.44.5 -j logdrop #Caught in router sylogs (Vietnam)
iptables -I FORWARD -s 123.16.0.0/12 -j logdrop #Caught in router sylogs (Vietnam - entire range)
iptables -I FORWARD -s 84.0.154.20 -j logdrop #Caught in router sylogs (Hungary)
iptables -I FORWARD -s 84.0.154.230 -j logdrop #Caught in router sylogs (Hungary)

#region Country IP blocks that have historically high hit counts:
iptables -I INPUT -s 58.48.0.0/13 -j logdrop
iptables -I INPUT -s 14.224.0.0/11 -j logdrop
iptables -I INPUT -s 51.79.0.0/16 -j logdrop
iptables -I INPUT -s 37.49.224.0/21 -j logdrop
iptables -I INPUT -s 37.59.0.0/16 -j logdrop
iptables -I INPUT -s 51.91.0.0/16 -j logdrop
iptables -I INPUT -s 1.160.0.0/12 -j logdrop
iptables -I INPUT -s 36.224.0.0/12 -j logdrop
iptables -I INPUT -s 49.4.0.0/14 -j logdrop
iptables -I INPUT -s 37.49.224.0/21 -j logdrop
iptables -I INPUT -s 37.59.0.0/16 -j logdrop
iptables -I INPUT -s 114.32.0.0/12 -j logdrop
iptables -I INPUT -s 39.8.0.0/13 -j logdrop
iptables -I INPUT -s 91.148.192.0/18 -j logdrop
iptables -I INPUT -s 113.96.0.0/12 -j logdrop
iptables -I INPUT -s 183.128.0.0/11 -j logdrop
iptables -I INPUT -s 134.19.176.0/20 -j logdrop
iptables -I INPUT -s 91.240.116.0/22 -j logdrop
iptables -I INPUT -s 27.34.240.0/20 -j logdrop
iptables -I INPUT -s 1.160.0.0/12 -j logdrop
iptables -I INPUT -s 36.224.0.0/12 -j logdrop
iptables -I INPUT -s 116.16.0.0/12 -j logdrop
iptables -I INPUT -s 106.192.0.0/11 -j logdrop
iptables -I INPUT -s 14.160.0.0/11 -j logdrop
iptables -I INPUT -s 14.224.0.0/11 -j logdrop
iptables -I INPUT -s 42.108.0.0/14 -j logdrop
iptables -I INPUT -s 111.240.0.0/12 -j logdrop
iptables -I INPUT -s 114.224.0.0/12 -j logdrop
iptables -I INPUT -s 59.124.0.0/14 -j logdrop
iptables -I INPUT -s 106.12.0.0/14 -j logdrop
iptables -I INPUT -s 117.192.0.0/10 -j logdrop
iptables -I INPUT -s 46.221.0.0/16 -j logdrop
iptables -I INPUT -s 81.212.0.0/14 -j logdrop
iptables -I INPUT -s 84.2.222.0/23 -j logdrop
iptables -I INPUT -s 82.197.192.0/19 -j logdrop
iptables -I INPUT -s 183.192.0.0/10 -j logdrop
iptables -I INPUT -s 46.107.112.0/21 -j logdrop
iptables -I INPUT -s 125.64.0.0/13 -j logdrop
iptables -I INPUT -s 176.63.0.0/16 -j logdrop
iptables -I INPUT -s 185.53.88.0/24 -j logdrop
iptables -I INPUT -s 178.128.128.0/17 -j logdrop
iptables -I INPUT -s 185.7.76.0/22 -j logdrop
iptables -I INPUT -s 85.148.0.0/14 -j logdrop
iptables -I INPUT -s 84.105.0.0/18 -j logdrop
iptables -I INPUT -s 112.0.0.0/10 -j logdrop
iptables -I INPUT -s 113.160.0.0/11 -j logdrop
iptables -I INPUT -s 122.224.0.0/12 -j logdrop
iptables -I INPUT -s 42.112.0.0/13 -j logdrop
iptables -I INPUT -s 59.88.0.0/13 -j logdrop
iptables -I INPUT -s 86.91.0.0/16 -j logdrop
iptables -I INPUT -s 182.56.0.0/14 -j logdrop
iptables -I INPUT -s 49.232.0.0/14 -j logdrop
iptables -I INPUT -s 77.243.189.0/28 -j logdrop
iptables -I INPUT -s 78.92.0.0/16 -j logdrop
iptables -I INPUT -s 81.204.0.0/14 -j logdrop
iptables -I INPUT -s 118.68.0.0/14 -j logdrop
iptables -I INPUT -s 122.116.0.0/15 -j logdrop
iptables -I INPUT -s 145.133.0.0/16 -j logdrop
iptables -I INPUT -s 145.236.0.0/16 -j logdrop
iptables -I INPUT -s 178.128.0.0/17 -j logdrop
iptables -I INPUT -s 185.142.236.0/22 -j logdrop
iptables -I INPUT -s 46.139.0.0/16 -j logdrop
iptables -I INPUT -s 89.132.0.0/14 -j logdrop
iptables -I FORWARD -s 58.48.0.0/13 -j logdrop
iptables -I FORWARD -s 14.224.0.0/11 -j logdrop
iptables -I FORWARD -s 51.79.0.0/16 -j logdrop
iptables -I FORWARD -s 37.49.224.0/21 -j logdrop
iptables -I FORWARD -s 37.59.0.0/16 -j logdrop
iptables -I FORWARD -s 51.91.0.0/16 -j logdrop
iptables -I FORWARD -s 1.160.0.0/12 -j logdrop
iptables -I FORWARD -s 36.224.0.0/12 -j logdrop
iptables -I FORWARD -s 49.4.0.0/14 -j logdrop
iptables -I FORWARD -s 37.49.224.0/21 -j logdrop
iptables -I FORWARD -s 37.59.0.0/16 -j logdrop
iptables -I FORWARD -s 114.32.0.0/12 -j logdrop
iptables -I FORWARD -s 39.8.0.0/13 -j logdrop
iptables -I FORWARD -s 91.148.192.0/18 -j logdrop
iptables -I FORWARD -s 113.96.0.0/12 -j logdrop
iptables -I FORWARD -s 183.128.0.0/11 -j logdrop
iptables -I FORWARD -s 134.19.176.0/20 -j logdrop
iptables -I FORWARD -s 91.240.116.0/22 -j logdrop
iptables -I FORWARD -s 27.34.240.0/20 -j logdrop
iptables -I FORWARD -s 1.160.0.0/12 -j logdrop
iptables -I FORWARD -s 36.224.0.0/12 -j logdrop
iptables -I FORWARD -s 116.16.0.0/12 -j logdrop
iptables -I FORWARD -s 106.192.0.0/11 -j logdrop
iptables -I FORWARD -s 14.160.0.0/11 -j logdrop
iptables -I FORWARD -s 14.224.0.0/11 -j logdrop
iptables -I FORWARD -s 42.108.0.0/14 -j logdrop
iptables -I FORWARD -s 111.240.0.0/12 -j logdrop
iptables -I FORWARD -s 114.224.0.0/12 -j logdrop
iptables -I FORWARD -s 59.124.0.0/14 -j logdrop
iptables -I FORWARD -s 106.12.0.0/14 -j logdrop
iptables -I FORWARD -s 117.192.0.0/10 -j logdrop
iptables -I FORWARD -s 46.221.0.0/16 -j logdrop
iptables -I FORWARD -s 81.212.0.0/14 -j logdrop
iptables -I FORWARD -s 84.2.222.0/23 -j logdrop
iptables -I FORWARD -s 82.197.192.0/19 -j logdrop
iptables -I FORWARD -s 183.192.0.0/10 -j logdrop
iptables -I FORWARD -s 46.107.112.0/21 -j logdrop
iptables -I FORWARD -s 125.64.0.0/13 -j logdrop
iptables -I FORWARD -s 176.63.0.0/16 -j logdrop
iptables -I FORWARD -s 185.53.88.0/24 -j logdrop
iptables -I FORWARD -s 178.128.128.0/17 -j logdrop
iptables -I FORWARD -s 185.7.76.0/22 -j logdrop
iptables -I FORWARD -s 85.148.0.0/14 -j logdrop
iptables -I FORWARD -s 84.105.0.0/18 -j logdrop
iptables -I FORWARD -s 112.0.0.0/10 -j logdrop
iptables -I FORWARD -s 113.160.0.0/11 -j logdrop
iptables -I FORWARD -s 122.224.0.0/12 -j logdrop
iptables -I FORWARD -s 42.112.0.0/13 -j logdrop
iptables -I FORWARD -s 59.88.0.0/13 -j logdrop
iptables -I FORWARD -s 86.91.0.0/16 -j logdrop
iptables -I FORWARD -s 182.56.0.0/14 -j logdrop
iptables -I FORWARD -s 49.232.0.0/14 -j logdrop
iptables -I FORWARD -s 77.243.189.0/28 -j logdrop
iptables -I FORWARD -s 78.92.0.0/16 -j logdrop
iptables -I FORWARD -s 81.204.0.0/14 -j logdrop
iptables -I FORWARD -s 118.68.0.0/14 -j logdrop
iptables -I FORWARD -s 122.116.0.0/15 -j logdrop
iptables -I FORWARD -s 145.133.0.0/16 -j logdrop
iptables -I FORWARD -s 145.236.0.0/16 -j logdrop
iptables -I FORWARD -s 178.128.0.0/17 -j logdrop
iptables -I FORWARD -s 185.142.236.0/22 -j logdrop
iptables -I FORWARD -s 46.139.0.0/16 -j logdrop
iptables -I FORWARD -s 89.132.0.0/14 -j logdrop
#endregion

#endregion

#region ipsum list (works with R7800 but not Archer C9 DD-WRT build):
for ip in $(curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    #do echo $ip; done #Confirm first
    do iptables -I INPUT -s $ip -j DROP;
    do iptables -I FORWARD -s $ip -j DROP;
done;
#endregion

echo $(date)

#region ipsum list - Compatible with Archer C9 DD-WRT build which doesn't have curl:
wget -O /tmp/ipsum.txt https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt
cat /tmp/ipsum.txt | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1 | while read line 
do
   #echo $line;
   do iptables -I INPUT -s $line -j DROP;
   do iptables -I FORWARD -s $line -j DROP;
done
#endregion

echo $(date)

###End of entry additions
#endregion

####Display for confirmation:
#iptables -vnL INPUT --line-numbers
#iptables -vnL FORWARD --line-numbers
#iptables -vnL INPUT --line-number | sort -r -g -k 2 | more
#iptables -vnL FORWARD --line-number | sort -r -g -k 2 | more