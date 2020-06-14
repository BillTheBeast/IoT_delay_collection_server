#!/bin/sh
echo "Provide the location of messagelog to calculate delays from"
read MESSAGELOG
curl -d "key=200&log=$MESSAGELOG" -X POST http://localhost:80/fnctn0