#!/bin/bash
## The first bunch of grep -v options are to remove noise from the log output, the next is to find the logins, 
##the awk is to remove blank lines (don't use sed, it messes with the quality of the output). Next awk is to 
##print just the relevant collumn. Additional irrelevant output removal, and finally stripping out the 
##characters, sorting the output, removing duplicates and output results into csv.
## It's not fancy, it's not beautiful, its just functional. use it don't use it...

cat cowrie.log* |grep -aEiv 'twisted.internet.error.ConnectionDone|Unhandled Error|"most recent call last"|
twisted.conch.telnet.OptionRefused|traceback|lost|failure'|grep -a login|awk 'NF'|grep -F /|awk '{
print $6}'|grep -aEv 'GET|expect|Accept|OPTIONS|From|Call|Max-Forwards|Contact|User'|sed 's/\[//g'|sed
's/\]//g'|sed 's/\//,/g'|sort|uniq > creds.csv
