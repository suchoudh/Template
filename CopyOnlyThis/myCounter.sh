#x ~~~~~~***myCounter.sh~~~~WeekNumber is 48 ~~~
#x ~~   File                :myCounter.sh 
#x ~~   Creation DateTime   :48_Fri_20231201-10_41_16
#x ~~   Last Updated Date   :2024-04-24 Wed 01:36 PM
#x ~~   End Date	
#x ~~   Author              : Sunil Choudhary 
#x ~~   Remarks             : TimeMyWorkAginstmyEstimates 
#x ~~                              1) can we add 6m+24 min  counter to this with a beep 
#x ~~                              2) need start time and end time without seconds as sometimes there is a break 
#x ~~				   3) start time/ end time /over time  countdown 
#x ~~				   4) default is 6 min message is also improved 24 apr 2024 
#x ~~ ~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#a 
touch NextAction.md   # will create a file which  can contain the next action tasks for today and near foreseen future. 
head NextAction.md


RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color
BLACK="\033[0;30m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
ORANGE="\033[0;33m"
LGRAY="\033[0;37m"
DGRAY="\033[1;30m"
LBLUE="\033[1;34m"
LGREEN="\033[1;32m"
LCYAN="\033[1;36m"
LRED="\033[1;31m"
LPURPLE="\033[1;35m"
YELLOW="\033[1;33m"
WHITE="\033[1;37m"
NORMAL="\033[m"

#Region --- Updates
#    echo -e "${PURPLE}RUNNING: sudo apt update --fix-missing${NC}"

echo Enter TaskName   # Only enter the time you want to dedicate yourself to  
read TASKNOTE
#TASKNOTE=$2
COUNTER=$1
PREDICTED="${COUNTER:=12}" # if counter is not set it defaults to 12 min ideally to use multiples of 12 min 

# FOO="${VARIABLE:-default}"  # FOO will be assigned 'default' value if VARIABLE not set or null.
# The value of VARIABLE remains untouched.

#FOO="${VARIABLE:=default}"  # If VARIABLE not set or null, set it's value to 'default'. 
# Then that value will be assigned to FOO


COUNTER=$(( COUNTER * 60 ))
#myPWD=$(( `pwd` ))
#myPWD=$(cd `dirname $0` && pwd)
myPWD=$(pwd)
OUTPUT=`date +%W_%a_%Y-%m-%d`   # use weeknum day and yy m and d in output for forcast.log 2024-02-09 Fri 10:51 PM
echo "We are working in $myPWD"
touch tmp.log 
cat tmp.log >> forecast$OUTPUT.log   # Concatenate to old logs 
echo $myPWD >>forecast$OUTPUT.log
cat tmp.log >> $LOGGER/forecast.log   # Concatenate to logger file as well  
echo $myPWD >> $LOGGER/forecast.log   # Concatenate to logger file as well  


sixMin () {
	mpg123 -q /home/rahu/Music/ShortBeep.mp3 
	echo -e "${GREEN}next 6  `date --date "+6 mins"  +"%H_%M"`"  # helps calculate next ping time 
	sleep 360 
}
twenty () {
echo -e "${RED} 24 min --- " 
}


cat tmp.log >> ~/Desktop/Doday/DoDayforecast$OUTPUT.log   # Concatenate to home folder  file as well  
echo $myPWD >> ~/Desktop/Doday/DoDayforecast$OUTPUT.log   # Concatenate to home folder  file as well  

while true
do
#	echo $COUNTER seconds remaining in $TASKNOTE for mandatory break :: press q/Q to quit  # this line colour to change based on 
	COUNTER=$(( COUNTER - 1 ))
	z=$(($COUNTER / 60))
#	z=$(($PREDICTED / 60))
	Actual=$(($PREDICTED-$z))   # minus as my z is negative and --=+ 
	Percentage=$((($PREDICTED-$z)*100/$PREDICTED))   # minus as my z is negative and --=+ 
#	echo $Actual
	
if [ $COUNTER -lt -60 ]    # within time  is ok  
then
    echo -e "${YELLOW} Countdown:$COUNTER ::  $Percentage % Time Used from Allocated $Actual minutes to do $TASKNOTE.:: `date` ${NC}" 
    echo -e "${YELLOW} Countdown:$COUNTER ::  $Percentage % Time Used from Allocated $Actual minutes to do $TASKNOTE.:: `date` ${NC}" > tmp.log  # Second line to log it 
elif [ $COUNTER -gt 60 ]  # more than a min late is late. 
then
    echo -e "${GREEN} Countdown:$COUNTER :: $Percentage % Time Used from Allocated $Actual minutes to do $TASKNOTE.:: `date`  ${NC}" 
    echo -e "${GREEN} Countdown:$COUNTER :: $Percentage % Time Used from Allocated $Actual minutes to do $TASKNOTE.:: `date`  ${NC}" > tmp.log  
else   # within a min is bulls eye 
    echo -e "${PURPLE} Countdown:$COUNTER :: $Percentage % Time Used from Allocated $Actual minutes to do $TASKNOTE. Good Job Sunil::  `date` ${NC}" 
    echo -e "${PURPLE} Countdown:$COUNTER :: $Percentage % Time Used from Allocated $Actual minutes to do $TASKNOTE. Good Job Sunil::  `date` ${NC}"  > tmp.log  # 
fi

sleep 1

# In the following line -t for timeout, -N for just 1 character
    read -t 0.25 -N 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
# The following line is for the prompt to appear on a new line.
        echo
	cat tmp.log >> forecast$OUTPUT.log   # Concatenate to old logs 
	cat tmp.log >> $LOGGER/forecast.log   # Concatenate to logger file as well  
	echo --- flushed at `date`---  >tmp.log 
        break 
    fi
done
#~~ Ran on 48_Fri_20231201-10_41_16
