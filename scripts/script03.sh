#!/bin/bash

set -eu

now=$(date -R -u | sed s/\\s+[0-9+-]*$//g)

folderName=$(date +%Y-%m-%d-%H%M)
# folderName="2022-12-03-1722"

path="/opt/weather/PROJECT/"

CITIESFOLDER="cities"

if [ -d "${path}$CITIESFOLDER/$folderName/" ]; then
    cd ${path}$CITIESFOLDER/$folderName/

else
    lastPathFound=$(ls -1 ${path}$CITIESFOLDER/ | tail -n1)
    cd "${path}$CITIESFOLDER/$lastPathFound"
    folderName=$lastPathFound
fi

regex1="([0-9.]+)"
regex2="(\w+)"

myli=""
IFS=$'\n'

for i in *; do


    city=$i

        
    tempList=$(grep -oP '<li>[0-9:]+ \K(.*)<\/li>' $i | sed 's/<\/li>//g')
    tempList=$(echo $tempList)
    

    forecast=$(grep -oP 'Forecast: \K(.)*<\/p>' $i | sed 's/<\/p>//g')

    updatedTime=$(grep -oP 'Fetched on \K(.)*<\/p>' $i | sed 's/<\/p>//g')



    
myli="${myli}<li><a href=\"../PROJECT/${CITIESFOLDER}/${folderName}/${city}\">${city}</a>: ($forecast) $tempList</li>""\n"
    
done



echo -e "

<!DOCTYPE html>
<html dir=\"ltr\" lang=\"en-US\">
    <head>
        <meta charset=\"UTF-8\" />
    </head>
    <body>
        <h1>Wheather forecast</h1>
        <p>Forecast update at $updatedTime</p>
        <ul>
            $myli
        </ul>
    </body>
</html>" > ../../main.html