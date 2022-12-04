#!/bin/bash

set -eu

path="/opt/weather/PROJECT/"

THEFOLDER="scraped-weather"

# arrays 
cities=( Gjøvik Bergen Oslo Tromsø Trondheim Kristiansand )
LON_ARR=( 60.7925 60.389444 59.913333 69.6489 63.429722 58.147222 )
LAT_ARR=( 10.695 5.33 10.738889 18.9551 10.393333 7.997222 )

cd ${path} 

# if the folder scraped-weather doesn't exist, it's created
if ! [ -d "$THEFOLDER" ]; then
    mkdir $THEFOLDER
fi

cd ${path}${THEFOLDER}

regex='air_temperature\":([0-9.-]+)'
regex2='symbol_code\":\"([0-9a-zA-Z_]*)\"'
regex3='relative_humidity\":([0-9.]+)'

k=0

for j in "${cities[@]}"; do

    if [ "$k" -eq 5 ]; then
        day=$(date +%d)
        day2=$(($day*10/2))
        lastDigit=${day2: -1}
        # is a odd day
        if [ "$lastDigit" -eq "0" ]; then
            continue
        else
            echo "Today we will get the Kristiansand city information"
        fi
    fi
    LAT="${LON_ARR[$k]}"
    LON="${LAT_ARR[$k]}"


    curl --silent "https://api.met.no/weatherapi/locationforecast/2.0/.json?lat=${LAT}&lon=${LON}" >tmp.txt

    # I will create a new line when air_temperature word appears
    sed -E s/\"air_temperature\"/\\n\"air_temperature\"/g tmp.txt >tmp2.txt

    # resp=$(cat tmp2.txt)

    IFS=$'\n'

    n=0
    tempArr=""
    forcastArr=""

    for i in $(cat tmp2.txt); do
        
        if [[ "$i" =~ $regex ]]; then

            temp=${BASH_REMATCH[1]}


            if [[ "$i" =~ $regex2 ]]; then

                forecast=${BASH_REMATCH[1]}

            fi

            if [ "$tempArr" = "" ]; then
                tempArr="$temp"
                forecastArr="$forecast"
            else
                tempArr="$tempArr\n$temp"
                # forecastArr="$forecastArr $forecast"
                
            fi

            if [[ "$i" =~ $regex3 ]]; then

                humidity=${BASH_REMATCH[1]}

            fi

            n=$(($n+1))

        fi

        
        # only three values are requested
        if [ "$n" -eq 3 ]; then
            break
        fi

    done

    # echo "$j"
    # echo "$tempArr"
    # echo "$forecastArr"
    now=$(date +%Y-%m-%d-%H%M)
    if ! [ -d "$now" ]; then
        mkdir $now
    fi
    echo "$j;$tempArr;$forecastArr;"
    echo -e "${j}\n${tempArr}\n${forecastArr}\n${now}\n${humidity}" >>${now}/${j}.txt

    k=$(($k+1))

    # exit 0

done

rm tmp.txt
rm tmp2.txt

exit 0