#x ~~~~~~***26m.sh~~~~WeekNumber is 48 ~~~
#x ~~   File                : 26m.sh 
#x ~~   Creation DateTime   :48_Sun_20231203-01_57_21
#x ~~   Last Updated Date   :5 dec 2023 morning 9 am 
#x ~~   End Date	
#x ~~   Author              : Sunil Choudhary 
#x ~~   Remarks             : pomodoro but of 24 and 6 min 24x60=60x24 also 6x4=24 and 24+6=30 
#x ~~                              1) find and add nescafe song as long 
#x ~~ ~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#a 
#`date --date "+26 mins"  +"%H_%M"`

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color
rows=3
cols=3
export DISPLAY=0.0


sixMin () {
	mpg123 -q /home/rahu/Music/ShortBeep.mp3 
	echo -e "${GREEN}next 6  `date --date "+6 mins"  +"%H_%M"`"  # helps calculate next ping time 
	sleep 360 
}
twenty () {
echo -e "${RED} 24 min --- " 
}

while true 
do 
twenty
sixMin
sixMin
sixMin
sixMin
done 



#~~ Ran on 48_Sun_20231203-01_57_21