#!/bin/bash
if ["$1"]; then
	MESSAGELOG = "$1"
else
	echo "Provide the location of messagelog to calculate delays from"
	read MESSAGELOG
fi
rfile=MESSAGELOG

while IFS= read -r rline
do
	num=$(echo "$rline" | awk -F"|" '{printf $1}')
	rtime=$(echo "$rline" | awk -F"|" '{printf $2}')
	mtime=$(echo "$rline" | awk -F"|" '{printf $3}')
	stime=$(echo "$rline" | awk -F"|" '{printf $4}')
	srtime=$rtime-($stime/1000000)
	smtime=$mtime-($stime/1000000000)
	mrtime=($rtime/1000)-$mtime
	echo $num'|'$srtime'|'$mrtime'|'$smtime > delaycalclog.txt
done < "$rfile"