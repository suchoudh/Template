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
askWhat () {
read -p "What is your intention  (24 min/6m stints, use b/B to indicate break )  ?
	" 
}

# mybBreak () {
# In the following line -t for timeout, -N for just 1 character
#    read -t 0.25 -N 1 input
#    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
# The following line is for the prompt to appear on a new line.
#        echo
#        break 
#    fi
#}

sixMin () {
#	mpg123 -q /home/rahu/Music/Ding.mp3 
	mpg123 -q /home/rahu/Music/Notify.mp3 
	echo -e "${GREEN}next 6  `date --date "+6 mins"  +"%H_%M"`"  # helps calculate next ping time 
	sleep 360 
#	sleep 2 
# In the following line -t for timeout, -N for just 1 character
    read -t 0.25 -N 1 input
    if [[ $input = "b" ]] || [[ $input = "B" ]]; then
# The following line is for the prompt to appear on a new line.
        echo -e "${YELLOW}Break time starts : ` date +"%H:%M" ` "
         
    fi


}
twenty () {
	echo -e "${RED}24 min ---  `date --date "+0 mins"  +"%H_%M"`"  # helps calculate next ping time 
	mpg123 -q /home/rahu/Music/Ding.mp3 
	sleep 1 
}

sixty () {
	echo -e "${PURPLE}60 min ---  `date --date "+0 mins"  +"%H_%M"`"  # helps calculate next ping time 
	mpg123 -q /home/rahu/Music/ShortBeep.mp3 
	sleep 1 
}


askWhat
#mybBreak
while true 
do 
sixMin
sixMin
sixMin
sixMin
sixMin
twenty
sixMin
sixMin
sixMin
sixMin
sixMin
sixty 
done 



#~~ Ran on 48_Sun_20231203-01_57_21
