#!/bin/bash
rfile="messagelog.txt"
sfile="lahetyslogi2.txt.txt"
while IFS= read -r rline
do
  echo "$rline" | awk -F"|" '{rnum = $5} {rtime = $3} {mtime = $6}'
	while IFS= read -r sline
	do
		echo "$sline" | awk -F" " '{snum = $4} {stime = $15} '
		if [ xxd -r "$rnum" == "$snum"]
		then
		echo "$snum|$rtime|$mtime|$stime"
	done < "$sfile"
  
  
  
  
done < "$rfile"