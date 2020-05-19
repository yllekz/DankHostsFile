#Build my hosts file

$HostsFile = 'c:\users\steve\Desktop\hosts.txt'

#region Put the hosts file together:

$HostsFileContent = @()

$HostsFileContent += Get-Content "D:\GitHub\DankHostsFile\CustomEntriesSK.txt"
$HostsFileContent += Get-Content "D:\GitHub\DankHostsFile\SpybotEntries.txt"

$HostsFileContent += "#region########################################################################################################################################"
$HostsFileContent += "# Start of StevenBlack Hosts"
$HostsFileContent += "# A select few entries have been unblocked to ensure sites like Hulu work."

$StevenBlackHosts = (invoke-webrequest "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts")

#$NoDupe = $StevenBlackHosts.rawcontent
#$Dedupe = $StevenBlackHosts.rawcontent | Sort-Object | get-unique
#Compare-Object -ReferenceObject $NoDupe -DifferenceObject $Dedupe

#region Define exceptions:
$Exceptions = @()

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 www.cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 zee.cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 www.zee.cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 ping.chartbeat.net";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 static.chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 www.chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 adsapi.chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 bat.bing.com";
    'Comment'   = "#Unblocked SK 2020/03/15";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 metrics.beachbody.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 chartbeat.net";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row
#endregion

#Comment out exceptions from above list. TODO: Figure out a way to make this into a loop...
$HostsFileContent += $StevenBlackHosts.RawContent

$1 = $HostsFileContent.replace($Exceptions[0].Entry, "#$($Exceptions[0].Entry) $($Exceptions[0].Comment)")
$2 = $1.replace($Exceptions[1].Entry, "#$($Exceptions[1].Entry) $($Exceptions[1].Comment)")
$3 = $2.replace($Exceptions[2].Entry, "#$($Exceptions[2].Entry) $($Exceptions[2].Comment)")
$4 = $3.replace($Exceptions[3].Entry, "#$($Exceptions[3].Entry) $($Exceptions[3].Comment)")
$5 = $4.replace($Exceptions[4].Entry, "#$($Exceptions[4].Entry) $($Exceptions[4].Comment)")
$6 = $5.replace($Exceptions[5].Entry, "#$($Exceptions[5].Entry) $($Exceptions[5].Comment)")
$7 = $6.replace($Exceptions[6].Entry, "#$($Exceptions[6].Entry) $($Exceptions[6].Comment)")
$8 = $7.replace($Exceptions[7].Entry, "#$($Exceptions[7].Entry) $($Exceptions[7].Comment)")
$9 = $8.replace($Exceptions[8].Entry, "#$($Exceptions[8].Entry) $($Exceptions[8].Comment)")
$10 = $9.replace($Exceptions[9].Entry, "#$($Exceptions[9].Entry) $($Exceptions[9].Comment)")
$11 = $10.replace($Exceptions[10].Entry, "#$($Exceptions[10].Entry) $($Exceptions[10].Comment)")
$12 = $11.replace($Exceptions[11].Entry, "#$($Exceptions[11].Entry) $($Exceptions[11].Comment)")
$12|out-file $HostsFile

"# End of entries inserted by StevenBlack hosts ########################################################################################################################################"|out-file $HostsFile -Append

#endregion