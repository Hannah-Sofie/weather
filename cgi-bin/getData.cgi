#!/bin/bash


path="/opt/weather/PROJECT/"

sudo bash ${path}../scripts/script03.sh
if [ "$?" -ne "0" ]; then
   echo "script03 didn't run as expected"
fi

cat "${path}main.html"