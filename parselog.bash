#!/bin/bash
rfile="messagelog.txt"
sfile="../lahetyslogi2.txt"
while IFS= read -r rline
do
  echo "$rline" | awk -F"|" '{rnumh = $5} {rtime = $3} {mtime = $6}'
	while IFS= read -r sline
	do
		echo "$sline" | awk -F" " '{snum = $4} {stime = $15} '
		rnum = xxd -r "$rnumh" 
		if [ "$rnum" == "$snum"]
		then
		echo "$snum|$rtime|$mtime|$stime"
		fi
	done < "$sfile"
  
  
  
  
done < "$rfile"