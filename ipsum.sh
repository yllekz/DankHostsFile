#!/bin/bash

#region Remove first:

echo $(date) #Command takes about 20 minutes to fully process
echo "Removing previous entries first..."
###Start of entry removals below:

#region Purge FORWARD table
#Purge existing Input table (keep the last 22 entries (20 entries + the two header lines), as those are placed there by default and we insert blocked entries before/above them)
#Harmless if the list is default (aka 22 lines)
blocked=`iptables -vnL FORWARD --line-numbers | wc -l`
subtraction=$((blocked-22))

#Ranged for loops are screwy in busybox:
#https://microdevsys.com/wp/how-to-create-a-for-loop-to-print-a-sequence-or-range-of-numbers-on-dd-wrt-or-busybox-devices-linux/
#https://www.linuxquestions.org/questions/programming-9/print-1-to-100-in-a-shell-script-680052/
for i in `seq 1 $subtraction`;
    #do echo "Removal ${i} of ${subtraction}";
    do iptables -D FORWARD 1; #Delete line 1 x amount of times
done;
#endregion

#region Purge INPUT table:
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
#endregion

#Purge existing Output table (harmless if the list is already blank)
iptables -F OUTPUT

#End of entry removals
#endregion

#region Now add entries:
echo $(date)
echo "Adding entries to iptables..."

#region Custom Entries SK
wget -O /tmp/root/IPBanList.txt https://raw.githubusercontent.com/yllekz/DankHostsFile/master/IPBanList.txt
for ip in $(cat /tmp/root/IPBanList.txt | grep -v "#");
    do iptables -I INPUT -s $ip -j DROP; iptables -I FORWARD -s $ip -j DROP; done;
#endregion

#region ipsum list (works on R7800, does not work on Archer C9):
#for ip in $(curl --compressed https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt 2>/dev/null | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    #do echo $ip; done #Confirm first
    #do iptables -I INPUT -s $ip -j DROP;
    #do iptables -I FORWARD -s $ip -j DROP;
#done;
#endregion

#region For Archer C9 (works on R7800 too):
wget -O /tmp/root/ipsum.txt https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt
for ip in $(cat /tmp/root/ipsum.txt | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    do iptables -I INPUT -s $ip -j DROP; done;

for ip in $(cat /tmp/root/ipsum.txt | grep -v "#" | grep -v -E "\s[1-2]$" | cut -f 1);
    do iptables -I FORWARD -s $ip -j DROP; done;
#endregion

echo $(date)

#endregion End of entry additions

####Display for confirmation:
#iptables -vnL INPUT --line-numbers|more
#iptables -vnL FORWARD --line-numbers|more
#iptables -vnL INPUT --line-number | sort -r -g -k 2 | more
#iptables -vnL FORWARD --line-number | sort -r -g -k 2 | more