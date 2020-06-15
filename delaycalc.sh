#!/bin/sh
if [$1]; then
	MESSAGELOG = $1
else
	echo "Provide the location of messagelog to calculate delays from"
	read MESSAGELOG
fi
curl -d "key=200&log=$MESSAGELOG" -X POST http://localhost:80/fnctn0