#!/bin/bash

if ["$1"]; then
	R_MESSAGELOG = "$1"
else
	echo "Provide the location of receive_messagelog"
	read R_MESSAGELOG
fi
if ["$2"]; then
	S_MESSAGELOG = "$2"
else
	echo "Provide the location of sent_messagelog"
	read S_MESSAGELOG
fi

rfile=R_MESSAGELOG
sfile=S_MESSAGELOG
re='^[0-9]+$'

while IFS= read -r rline
do
	rnum=$(echo "$rline" | awk -F"|" '{printf $5}')
	rtime=$(echo "$rline" | awk -F"|" '{printf $3}')
	mtime=$(echo "$rline" | awk -F"|" '{printf $6}' | tr -d '\r')
	if ! [[ $rnum =~ $re ]] ; then
		continue
	fi
	while IFS= read -r sline
	do
		snum=$(echo "$sline" | awk -F" " '{printf $4}')
		stime=$(echo "$sline" | awk -F" " '{printf $15}')
		if [ $(echo $rnum | xxd -r) -eq "$snum" ]
		then
		echo "$snum|$rtime|$mtime|$stime" > parsedmessagelogs.txt
		break
		fi
	done < "$sfile"
done < "$rfile"