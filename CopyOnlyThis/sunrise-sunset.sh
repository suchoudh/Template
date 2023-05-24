#~~ ~~~~~WeekNumber is 41~~~~~***sunrise-sunset.sh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~   File                : /home/rahu/2working2/sunsetRise/Sunrise-Sunset-Shell-Script/sunrise-sunset.sh 
#~~   Creation DateTime   :41_20221015-18_51
#~~   Last Updated Date   :41_20221015-18_51 
#~~   End Date	
#~~   Author              : Sunil Choudhary 
#~~   Remarks             :  
#~~                              1) This is first point 
#~~ Sandhyākāla is totally 72 minutes (i.e. 3 ghaṭīs).[10]: 218 
#~~     Prātassandhyā spans from two ghaṭīs[note 7] before sunrise and until one ghaṭī after it.
#~~     Madhyāhna sandhyā spans from one and half ghaṭī before noon and until one and half ghaṭī after it.
#~~     Sāyam sandhyā spans from one ghaṭī before sunset and until two ghaṭīs after it.
#~~ 
#~~ 
#~~ ~~~~~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#aaaa 
#!/bin/bash

# First obtain a location code from: https://weather.codes/search/

# Insert your location. For example LOXX0001 is a location code for Bratislava, Slovakia
location="INXX0023"
tmpfile=/tmp/$location.out

# Obtain sunrise and sunset raw data from weather.com
wget -q "https://weather.com/weather/today/l/$location" -O "$tmpfile"

SUNR=$(grep SunriseSunset "$tmpfile" | grep -oE '((1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm]))' | head -1)
SUNS=$(grep SunriseSunset "$tmpfile" | grep -oE '((1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm]))' | tail -1)


sunrise=$(date --date="$SUNR" +%R)
sunset=$(date --date="$SUNS" +%R)

# Use $sunrise and $sunset variables to fit your needs. Example:
echo "Sunrise for location $location: $sunrise"
echo "Sunset for location $location: $sunset"
#~~ Ran on 41_20221015-18_51
