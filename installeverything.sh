#This should go into the startup section of DD-WRT's Commands.

sleep 300; #Grace period in case you get locked uot of the router.

#Pull hosts file script and run it
hostsscript=/tmp/root/installhosts.sh
wget -O $hostsscript https://raw.githubusercontent.com/yllekz/DankHostsFile/master/installhosts.sh;
./$hostsscript

#Pull ipsum script and run it
ipsumscript=/tmp/root/ipsum.sh
wget -O $ipsumscript https://raw.githubusercontent.com/yllekz/DankHostsFile/master/ipsum.sh;
./$ipsumscript