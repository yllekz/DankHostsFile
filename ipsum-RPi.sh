#!/bin/bash

#region Remove first:

echo $(date) #Command takes about 20 minutes to fully process
echo "Removing previous entries first..."
###Start of entry removals below:

#region Purge INPUT table:
sudo iptables -F INPUT
#endregion

#End of entry removals
#endregion

#region Now add entries:
echo $(date)
echo "Adding entries to iptables..."

#region Custom entries SK

#region Various country CIDR blocks:
sudo iptables -I INPUT -s 42.48.0.0/15 -j DROP; #CN - entire range
sudo iptables -I INPUT -s 54.36.0.0/16 -j DROP; #FR - entire range
#endregion

#region Minecraft vandals:
sudo iptables -I INPUT -s 45.141.153.162 -j DROP; #(US - NY)
sudo iptables -I INPUT -s 185.209.177.52 -j DROP; #(US - LA)
sudo iptables -I INPUT -s 173.49.229.128 -j DROP; #(US - VA)
#endregion

#region OpenVPN Failed connections:
sudo iptables -I INPUT -s 60.190.224.0/19 -j DROP; #(CN - Entire Range)
sudo iptables -I INPUT -s 122.228.19.64/27 -j DROP; #(CN - Entire Range)
sudo iptables -I INPUT -s 164.52.0.0/17 -j DROP; #(CN - Entire Range)
sudo iptables -I INPUT -s 185.200.118.0/24 -j DROP; #(UK - London - entire range)
sudo iptables -I INPUT -s 146.88.240.0/20 -j DROP; #(US - MI - entire range)
sudo iptables -I INPUT -s 192.35.168.0/23 -j DROP; #(US - MI - entire range)
sudo iptables -I INPUT -s 162.142.125.0/24 -j DROP; #(US - MI - entire range)
sudo iptables -I INPUT -s 66.240.192.128/26 -j DROP; #(US - CA - entire range)
#endregion

#region Caught in router syslogs:
sudo iptables -I INPUT -s 71.6.165.192 -j DROP #(US - CA)
sudo iptables -I INPUT -s 171.67.70.87 -j DROP; #(US - CA)
sudo iptables -I INPUT -s 220.134.0.0/16 -j DROP; #(Taiwan - entire range)
sudo iptables -I INPUT -s 117.192.0.0/10 -j DROP; #(India - entire range)
sudo iptables -I INPUT -s 85.99.244.0/23 -j DROP; #(Turkey - entire range)
sudo iptables -I INPUT -s 37.49.224.0/24 -j DROP; #(Netherlands - entire range)
sudo iptables -I INPUT -s 123.16.0.0/12 -j DROP; #(Vietnam - entire range)
sudo iptables -I INPUT -s 84.0.154.20 -j DROP; #(Hungary)
sudo iptables -I INPUT -s 84.0.154.230 -j DROP; #(Hungary)
#endregion

#region Country IP blocks that have historically high hit counts:
sudo iptables -I INPUT -s 58.48.0.0/13 -j DROP;
sudo iptables -I INPUT -s 14.224.0.0/11 -j DROP;
sudo iptables -I INPUT -s 51.79.0.0/16 -j DROP;
sudo iptables -I INPUT -s 37.49.224.0/21 -j DROP;
sudo iptables -I INPUT -s 37.59.0.0/16 -j DROP;
sudo iptables -I INPUT -s 51.91.0.0/16 -j DROP;
sudo iptables -I INPUT -s 1.160.0.0/12 -j DROP;
sudo iptables -I INPUT -s 36.224.0.0/12 -j DROP;
sudo iptables -I INPUT -s 49.4.0.0/14 -j DROP;
sudo iptables -I INPUT -s 114.32.0.0/12 -j DROP;
sudo iptables -I INPUT -s 39.8.0.0/13 -j DROP;
sudo iptables -I INPUT -s 91.148.192.0/18 -j DROP;
sudo iptables -I INPUT -s 113.96.0.0/12 -j DROP;
sudo iptables -I INPUT -s 183.128.0.0/11 -j DROP;
sudo iptables -I INPUT -s 134.19.176.0/20 -j DROP;
sudo iptables -I INPUT -s 91.240.116.0/22 -j DROP;
sudo iptables -I INPUT -s 27.34.240.0/20 -j DROP;
sudo iptables -I INPUT -s 116.16.0.0/12 -j DROP;
sudo iptables -I INPUT -s 106.192.0.0/11 -j DROP;
sudo iptables -I INPUT -s 14.160.0.0/11 -j DROP;
sudo iptables -I INPUT -s 42.108.0.0/14 -j DROP;
sudo iptables -I INPUT -s 111.240.0.0/12 -j DROP;
sudo iptables -I INPUT -s 114.224.0.0/12 -j DROP;
sudo iptables -I INPUT -s 59.124.0.0/14 -j DROP;
sudo iptables -I INPUT -s 106.12.0.0/14 -j DROP;
sudo iptables -I INPUT -s 117.192.0.0/10 -j DROP;
sudo iptables -I INPUT -s 46.221.0.0/16 -j DROP;
sudo iptables -I INPUT -s 81.212.0.0/14 -j DROP;
sudo iptables -I INPUT -s 84.2.222.0/23 -j DROP;
sudo iptables -I INPUT -s 82.197.192.0/19 -j DROP;
sudo iptables -I INPUT -s 183.192.0.0/10 -j DROP;
sudo iptables -I INPUT -s 46.107.112.0/21 -j DROP;
sudo iptables -I INPUT -s 125.64.0.0/13 -j DROP;
sudo iptables -I INPUT -s 176.63.0.0/16 -j DROP;
sudo iptables -I INPUT -s 185.53.88.0/24 -j DROP;
sudo iptables -I INPUT -s 178.128.128.0/17 -j DROP;
sudo iptables -I INPUT -s 185.7.76.0/22 -j DROP;
sudo iptables -I INPUT -s 85.148.0.0/14 -j DROP;
sudo iptables -I INPUT -s 84.105.0.0/18 -j DROP;
sudo iptables -I INPUT -s 112.0.0.0/10 -j DROP;
sudo iptables -I INPUT -s 113.160.0.0/11 -j DROP;
sudo iptables -I INPUT -s 122.224.0.0/12 -j DROP;
sudo iptables -I INPUT -s 42.112.0.0/13 -j DROP;
sudo iptables -I INPUT -s 59.88.0.0/13 -j DROP;
sudo iptables -I INPUT -s 86.91.0.0/16 -j DROP;
sudo iptables -I INPUT -s 182.56.0.0/14 -j DROP;
sudo iptables -I INPUT -s 49.232.0.0/14 -j DROP;
sudo iptables -I INPUT -s 77.243.189.0/28 -j DROP;
sudo iptables -I INPUT -s 78.92.0.0/16 -j DROP;
sudo iptables -I INPUT -s 81.204.0.0/14 -j DROP;
sudo iptables -I INPUT -s 118.68.0.0/14 -j DROP;
sudo iptables -I INPUT -s 122.116.0.0/15 -j DROP;
sudo iptables -I INPUT -s 145.133.0.0/16 -j DROP;
sudo iptables -I INPUT -s 145.236.0.0/16 -j DROP;
sudo iptables -I INPUT -s 178.128.0.0/17 -j DROP;
sudo iptables -I INPUT -s 185.142.236.0/22 -j DROP;
sudo iptables -I INPUT -s 46.139.0.0/16 -j DROP;
sudo iptables -I INPUT -s 89.132.0.0/14 -j DROP;
#endregion

#endregion

#ipsum list:
for ip in $(curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    do sudo iptables -I INPUT -s $ip -j DROP;
done;
#endregion

echo $(date)

###End of entry additions
#endregion

####Display for confirmation:
#sudo iptables -vnL INPUT --line-numbers|more
#sudo iptables -vnL INPUT --line-number | sort -r -g -k 2 | more