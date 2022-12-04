#!/bin/bash

set -eu

# now=$(date -R -u | sed s/\\s+[0-9+-]*$//g)
path="/opt/weather/PROJECT/"

now=$(date +%Y-%m-%d-%H%M)

myHour=$(date +%H)

folderName=$(date +%Y-%m-%d-%H%M)
# folderName="2022-11-29-1411"

lastModification=$(date --reference=../scripts/data-collected.txt -R -u | sed s/\\s+[0-9+-]*$//g)

updatedTime=$(date +"%Y-%m-%d %H:%M")

cd ${path}

CITIESFOLDER="cities"
# if the folder cities doesn't exist, it's created
if ! [ -d "$CITIESFOLDER" ]; then
    mkdir $CITIESFOLDER
fi

if ! [ -d "${CITIESFOLDER}/${now}" ]; then
    mkdir ${CITIESFOLDER}/$now
fi

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
            tempList="$tempList <li>${thisHour}:00 $j</li>\n"

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

    
# Create the html file for each city
echo -e "<!DOCTYPE html> 
<html dir=\"ltr\" lang=\"en-US\">
<head> 
<meta charset=\"utf-8\">
<title>Weather forecast for ${city}</title> 

</head> 
<body> 
<h1>Weather forecast for ${city}</h1>
<p>Temperatures:</p>
<ul>
$tempList
</ul>
<p>Forecast: $forecastList</p>
<p>Fetched on $fetched</p> 
<p>Humidity (%): $humidity</p> 
</body>
</html>" > ../../${CITIESFOLDER}/$now/${city}.html


done


echo "HTML files created"
exit 0





