#!/bin/sh
echo "Provide the location of receive_messagelog"
read R_MESSAGELOG
echo "Provide the location of sent_messagelog"
read S_MESSAGELOG
curl -d "key=100&rlog=$R_MESSAGELOG&slog=S_MESSAGELOG" -X POST http://localhost:80/fnctn0