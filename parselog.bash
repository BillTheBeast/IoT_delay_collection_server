#!/bin/bash
rfile="messagelog.txt"
sfile="../lahetyslogi2.txt"
while IFS= read -r rline
do
	rnum=$(echo "$rline" | awk -F"|" '{printf $5}')
	rtime=$(echo "$rline" | awk -F"|" '{printf $3}')
	mtime=$(echo "$rline" | awk -F"|" '{printf $6}')
	while IFS= read -r sline
	do
		snum=$(echo "$sline" | awk -F" " '{printf $4}')
		stime=$(echo "$sline" | awk -F" " '{printf $15}')
		if [ $(echo $rnum | xxd -r)=="$snum"]
		then
		echo "$snum|$rtime|$mtime|$stime"
		fi
	done < "$sfile"
  
  
  
  
done < "$rfile"