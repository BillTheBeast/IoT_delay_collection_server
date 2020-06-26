#!/bin/bash
if [ -f "$1" ]; then
	MESSAGELOG="$1"
else
	echo "Provide the location of email messages"
	read MESSAGELOG
fi
rfile=$MESSAGELOG

dates=""
subject=""
mtime=""
num=""
i=0
while IFS= read -r rline
do
	ident=$(echo "$rline" | awk -F":" '{printf $1}')
	if [[ $ident == "Date" ]]; then
		dtime=$(echo "$rline" | awk -F":" '{printf $2}')':'$(echo "$rline" | awk -F":" '{printf $3}')':'$(echo "$rline" | awk -F":" '{printf $4}')
		dates=$ident":"$(date -d "${dtime}" +%s)
		i=$((i+1))
	elif [[ $ident == "Subject" ]]; then
		if [[ $(echo "$rline" | awk -F":" '{printf $2}') == " IoT 1D96BE ilmoitus" ]]; then
			subject=$rline
			i=$((i+1))
		else
			i=0
			continue
		fi
	elif [[ $ident == "Aika" ]]; then
		mtime=$rline
		i=$((i+1))
	elif [[ $ident == "Sarjanumero" ]]; then
		num=$rline
		i=$((i+1))
	fi
	if [ $i -eq 4 ]; then
		echo "$dates|$subject|$num|$mtime"
		i=0
	fi
done < "$rfile"
