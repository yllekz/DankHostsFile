#!/bin/bash

#region Remove first:
echo $(date);echo "Removing previous entries first...";
#Purge INPUT table:
sudo iptables -F INPUT;
#endregion

#region Now add entries:
echo $(date);echo "Adding entries to iptables...";

#Custom entries SK
for ip in $(curl --compressed https://raw.githubusercontent.com/yllekz/DankHostsFile/master/IPBanList.txt 2>/dev/null | grep -v "#");
    do sudo iptables -I INPUT -s $ip -j DROP;
done;

#ipsum list:
for ip in $(curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    do sudo iptables -I INPUT -s $ip -j DROP;
done;

#Country blacklist:
#for ip in $(curl --compressed https://raw.githubusercontent.com/yllekz/DankHostsFile/master/CountryBlacklist.txt 2>/dev/null | grep -v "#");
#    do sudo iptables -I INPUT -s $ip -j DROP;
#done;
#endregion end of entry additions

echo $(date);

####Display for confirmation:
#sudo iptables -vnL INPUT --line-numbers|more
#sudo iptables -vnL INPUT --line-number | sort -r -g -k 2 | more