#!/bin/bash

if [ -f "$1" ]; then
	R_MESSAGELOG="$1"
else
	echo "Provide the location of receive_messagelog"
	read R_MESSAGELOG
fi
if [ -f "$2" ]; then
	S_MESSAGELOG="$2"
else
	echo "Provide the location of sent_messagelog"
	read S_MESSAGELOG
fi

rfile="$R_MESSAGELOG"
sfile="$S_MESSAGELOG"
re='^[0-9]+$'

highnum=0

while IFS= read -r sline
do
	snum=$(echo "$sline" | awk -F" " '{printf $4}')
	if [ "$snum" -gt "$highnum" ]
	then
	highnum="$snum"
	fi
done <<<$(cat "$sfile")

echo "Starting parse..."
cat "$rfile" | while IFS= read -r rline
do
	rnum=$(echo "$rline" | awk -F"|" '{printf $5}')
	rtime=$(echo "$rline" | awk -F"|" '{printf $3}')
	mtime=$(echo "$rline" | awk -F"|" '{printf $6}' | tr -d '\r')
	if ! [[ $rnum =~ $re ]] ; then
		continue
	fi
	if [ $(echo $rnum | xxd -r -p) -gt "$highnum" ]
	then
		break
	fi
	cat "$sfile" | while IFS= read -r sline
	do
		snum=$(echo "$sline" | awk -F" " '{printf $4}')
		if [ $(echo $rnum | xxd -r -p) -lt "$snum" ]
		then
		break
		elif [ $(echo $rnum | xxd -r -p) -eq "$snum" ]
		then
		stime=$(echo "$sline" | awk -F" " '{printf $15}')
		echo "$snum|$rtime|$mtime|$stime"
		break
		fi
	done
done
echo "Parsing finished"
