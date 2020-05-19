#Build my hosts file
<# 
-Deduplicate StevenBlack entries separately (do this first in a different text file)
-CTRL F for "#Unblocked" to find custom entries I unblocked to ensure things like Hulu don't break. Compare those entries with the ones you are about to paste in and match them.
-Paste in StevenBlack entries at the bottom, replacing the existing one.
---Paste starting at the "# Hosts contributed by Steven Black" line.
-Check for/Deduplicate my custom entries via Visual Studio Code with the "DupChecker" extension (Ctrl Shift P and run "check duplicates" then view the Output tab) #>

$Exceptions = @("")

"#0.0.0.0 cws.conviva.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 www.cws.conviva.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 zee.cws.conviva.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 www.zee.cws.conviva.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 chartbeat.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 ping.chartbeat.net #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 static.chartbeat.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 www.chartbeat.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 adsapi.chartbeat.com #Unblocked SK 2020/03/15 [BeachBody]"
"#0.0.0.0 bat.bing.com #Unblocked SK 2020/03/15"
"#0.0.0.0 metrics.beachbody.com #Unblocked SK 2020/03/11 [BeachBody]"
"#0.0.0.0 chartbeat.net #Unblocked SK 2020/03/15 [BeachBody]"