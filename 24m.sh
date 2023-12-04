#x ~~~~~~***26m.sh~~~~WeekNumber is 48 ~~~
#x ~~   File                : 26m.sh 
#x ~~   Creation DateTime   :48_Sun_20231203-01_57_21
#x ~~   Last Updated Date   :48_Sun_20231203-01_57_21 
#x ~~   End Date	
#x ~~   Author              : Sunil Choudhary 
#x ~~   Remarks             : pomodoro but of 24 and 6 min 24x60=60x24 also 6x4=24 and 24+6=30 
#x ~~                              1) find and add nescafe song as long 
#x ~~                              2) add 6 min as short BTW i do have cron for notify-send so its  OK kind of 
#x ~~                              3) let this run without blocking a terminal 
#x ~~ ~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#a 
#`date --date "+26 mins"  +"%H_%M"`

RED='\033[1;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color


export DISPLAY=0.0
while true
do
	echo -e "${RED}Pinged at `date`"  # helps calculate next ping time 
	echo -e "${GREEN}NeXT Ping at `date --date "+26 mins"  +"%H_%M"`"  # helps calculate next ping time 
	mpg123 -q /home/rahu/Music/ShortBeep.mp3 
sleep 1440  # is 24 min 


# In the following line -t for timeout, -N for just 1 character
    read -t 0.25 -N 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
# The following line is for the prompt to appear on a new line.
        echo
        break 
    fi
done
#~~ Ran on 48_Sun_20231203-01_57_21
