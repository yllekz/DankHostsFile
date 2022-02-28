# Build my hosts file. Pulls from: 
# 1. My own custom entries [in this repo]
# 2. Spybot S+D Immunization Entries [in this repo]
# 3. StevenBlack Hosts [pull from his GitHub]
# 4. Exceptions [defined in this file below]
# 5. YouTube ad list [pull from their GitHub]

if($IsLinux -eq $true){
    $HostsFile = "$($HOME)/Desktop/hosts.txt"
    $CustomEntriesFile = "$($PSSCRIPTROOT)/CustomEntriesSK.txt"
    $SpybotEntriesFile = "$($PSSCRIPTROOT)/SpybotEntries.txt"
}elseif($IsMacOS -eq $true ){
    $HostsFile = "$($HOME)/Desktop/hosts.txt"
    $CustomEntriesFile = "$($PSSCRIPTROOT)/CustomEntriesSK.txt"
    $SpybotEntriesFile = "$($PSSCRIPTROOT)/SpybotEntries.txt"
}else{
    $HostsFile = "c:\users\$($env:USERNAME)\Desktop\hosts.txt"
    $CustomEntriesFile = "$($PSSCRIPTROOT)\CustomEntriesSK.txt"
    $SpybotEntriesFile = "$($PSSCRIPTROOT)\SpybotEntries.txt"
}

#region Put the hosts file together:

$HostsFileContent = @()

$HostsFileContent += Get-Content $CustomEntriesFile
$HostsFileContent += Get-Content $SpybotEntriesFile

$HostsFileContent += "#region########################################################################################################################################"
$HostsFileContent += "# Start of StevenBlack Hosts"
$HostsFileContent += "# A select few entries have been unblocked to ensure sites like Hulu work."

$StevenBlackHosts = (invoke-webrequest "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts")
$YouTubeAds = (Invoke-WebRequest "https://raw.githubusercontent.com/kboghdady/youTube_ads_4_pi-hole/master/youtubelist.txt")
$SmartTV1 = (Invoke-WebRequest "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt")
$SmartTV2 = (Invoke-WebRequest "https://raw.githubusercontent.com/tarvcode/pihole-smart-tv/main/pihole-smart-tv.txt")

#$NoDupe = $StevenBlackHosts.rawcontent
#$Dedupe = $StevenBlackHosts.rawcontent | Sort-Object | get-unique
#Compare-Object -ReferenceObject $NoDupe -DifferenceObject $Dedupe

#region Define exceptions:
$Exceptions = @()

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 www.cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 zee.cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 www.zee.cws.conviva.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 ping.chartbeat.net";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 static.chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 www.chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 adsapi.chartbeat.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 bat.bing.com";
    'Comment'   = "#Unblocked SK 2020/03/15";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 metrics.beachbody.com";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 chartbeat.net";
    'Comment'   = "#Unblocked SK 2020/03/15 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 metrics.teambeachbody.com";
    'Comment'   = "#Unblocked SK 2020/05/26 [BeachBody]";
}
$Exceptions += $row

$row = new-object PSObject -Property @{
    'Entry'     = "0.0.0.0 partnerad.l.doubleclick.net";
    'Comment'   = "#Unblocked SK 2021/10/26 [Paramount+]";
}
$Exceptions += $row
#endregion

#region Comment out exceptions from above list. TODO: Figure out a way to make this into a loop...
$HostsFileContent += $StevenBlackHosts.Content

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
$13 = $12.replace($Exceptions[12].Entry, "#$($Exceptions[12].Entry) $($Exceptions[12].Comment)")
$14 = $13.replace($Exceptions[13].Entry, "#$($Exceptions[13].Entry) $($Exceptions[13].Comment)")
$14|out-file $HostsFile
#endregion

"# End of entries inserted by StevenBlack hosts ########################################################################################################################################"|out-file $HostsFile -Append

#region YouTube Ads (not using due to being too unreliable)
<# "#region########################################################################################################################################" |out-file $HostsFile -Append
"# Start of YouTube ad server list" |out-file $HostsFile -Append
foreach($line in $YouTubeAds.Content){
    if($line -match "#"){
        $line | out-file $HostsFile -Append
    }else{
        "0.0.0.0 $($line)" | out-file $HostsFile -Append
    }
}
"# End of entries inserted by YouTube ad server list ########################################################################################################################################"|out-file $HostsFile -Append
 #>
#endregion

#region Smart TVs (some are shared between the two but each contain some unique/exclusive entries)
"#region########################################################################################################################################" |out-file $HostsFile -Append
"# Start of Smart TV server list" |out-file $HostsFile -Append
foreach($line in $SmartTV1.Content){
    if($line -match "#"){
        $line | out-file $HostsFile -Append
    }else{
        "0.0.0.0 $($line)" | out-file $HostsFile -Append
    }
}

foreach($line in $SmartTV2.Content){
    if($line -match "#"){
        $line | out-file $HostsFile -Append
    }else{
        "0.0.0.0 $($line)" | out-file $HostsFile -Append
    }
}
"# End of entries inserted by Smart TV server list ########################################################################################################################################"|out-file $HostsFile -Append

#endregion

#endregion