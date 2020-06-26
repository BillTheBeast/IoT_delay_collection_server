#!/bin/bash
if [ -t 0 ]; then
	MESSAGELOG='$0'
elif [ -f "$1" ]; then
	MESSAGELOG="$1"
fi
rfile=$MESSAGELOG

echo "Msg-num|Send-to-Server[ms]|Mware-to-Server[s]|Send-to-Mware[s]|Send-to-Email[s]|Mware-to-Email[s]"

while IFS= read -r rline
do
	num=$(echo "$rline" | awk -F"|" '{printf $1}')
	rtime=$(echo "$rline" | awk -F"|" '{printf $2}')
	mtime=$(echo "$rline" | awk -F"|" '{printf $3}')
	stime=$(echo "$rline" | awk -F"|" '{printf $4}')
	etime=$(echo "$rline" | awk -F"|" '{printf $5}')
	srtime=$((rtime-stime/1000000))
	smtime=$((mtime-stime/1000000000))
	mrtime=$((rtime/1000-mtime))
	setime=$((etime-stime/1000000000))
	metime=$((etime-mtime))
	echo $rline'|'$srtime'|'$mrtime'|'$smtime'|'$setime'|'$metime
done < "${rfile:-/dev/stdin}"
