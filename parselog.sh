#!/bin/sh
if [$1]; then
	R_MESSAGELOG = $1
else
	echo "Provide the location of receive_messagelog"
	read R_MESSAGELOG
fi
if [$2]; then
	S_MESSAGELOG = $2
else
	echo "Provide the location of sent_messagelog"
	read S_MESSAGELOG
fi
curl -d "key=100&rlog=$R_MESSAGELOG&slog=$S_MESSAGELOG" -X POST http://localhost:80/fnctn0