#!/bin/bash

topic="idg1100-562963"




set -eu


path="/opt/weather/PROJECT/"


myHour=$(date +%H)

folderName=$(date +%Y-%m-%d-%H%M)
folderName="2022-12-03-1722"

cd ${path}

THEFOLDER="scraped-weather"

cd ${path}${THEFOLDER}

regex1="([0-9.]+)"
regex2="(\w+)"

myli=""
IFS=$'\n'

cd $folderName

for i in *; do

    nline=1
    tempList=""
    humidity=""
    for j in $(cat "$i"); do
        # echo "**$j"
        if [ "$nline" -eq 1 ]; then
            city=$j
        fi
        if [ "$nline" -ge 2 ] && [ "$nline" -le 4 ]; then
            thisHour=$((${myHour}+$nline-2))
            tempList="$tempList $j"

        fi
        if [ "$nline" -eq 5 ]; then
            forecastList=$j
        fi
        if [ "$nline" -eq 6 ]; then
            fetched=$j
        fi
        if [ "$nline" -eq 7 ]; then
            humidity=$j

        fi
        nline=$(($nline+1))
    done

    




myli="${myli}${city}: ($forecastList) $tempList\n"
done









# echo "$myli"


curl \
  -H "Title: The last forecast at $fetched " \
  -H "Priority: urgent" \
  -H "Tags: forecast,weather" \
  -d "$(echo "$myli")" \
  ntfy.sh/${topic}



exit 0