#!/bin/bash

if [ -f "$1" ]; then
	M_MESSAGELOG="$1"
else
	echo "Provide the location of receive_messagelog"
	read M_MESSAGELOG
fi
if [ -f "$2" ]; then
	R_MESSAGELOG="$2"
else
	echo "Provide the location of sent_messagelog"
#	read R_MESSAGELOG
fi

rfile=$R_MESSAGELOG
mfile=$M_MESSAGELOG
re='^[0-9]+$'

while IFS= read -r rline
do
	rnum=$(echo "$rline" | cut -d"|" -f1)
	if ! [[ $rnum =~ $re ]] ; then
		continue
	fi
	cat "$mfile" | while IFS= read -r mline
	do
		enum=$(echo "$mline" | cut -d"|" -f3 | cut -d":" -f2)
		etime=$(echo "$mline" | cut -d"|" -f1 | cut -d":" -f2)
		if [ $(echo $enum | xxd -r -p) -eq "$rnum" ]
		then
		echo "$rline|$etime"
		break
		fi
	done
done < "${rfile:-/dev/stdin}"
