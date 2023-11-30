RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

## For reference Only 
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

# Log Format for forecast.log (to be done 30 nov 2023 ) 
# Remark :Good Job Sunil | Task : Lunch | Estimate : 26 min | Actual: 27 min | Deviation : + 1 Min | % :  3% more 
# Remark :UnderEstimated  | Task : Lunch | Estimate : 26 min | Actual: 66 min | Deviation : + 40 Min | % :  76% more time 
# Remark :OverEstimated | Task : Lunch | Estimate : 26 min | Actual: 16 min | Deviation : - 4 Min | % :  15% less time 

#Region --- Updates
#    echo -e "${PURPLE}RUNNING: sudo apt update --fix-missing${NC}"




COUNTER=$1
TASKNOTE=$2
PREDICTED=$1
COUNTER=$(( COUNTER * 60 ))
touch tmp.log 
cat tmp.log >> forecast.log   # Concatenate to old logs 
#cat tmp.log >> $LOGGER/forecast.log   # Concatenate to logger file as well  
while true
do
#	echo $COUNTER seconds remaining in $TASKNOTE for mandatory break :: press q/Q to quit  # this line colour to change based on 
	COUNTER=$(( COUNTER - 1 ))
	z=$(($COUNTER / 60))
	Actual=$(($PREDICTED-$z))   # minus as my z is negative and --=+ 
	Percentage=$((($PREDICTED-$z)*100/$PREDICTED))   # minus as my z is negative and --=+ 
#	echo $Actual
	
if [ $COUNTER -lt -60 ]    # within a min is bulls eye 
then
    echo -e "${RED} $Percentage MORE predicted time for tasknote $TASKNOTE:$1 Actual ::$Actual .. took $COUNTER secs MORE on `date` ${NC}" 
    echo $Percentage percent MORE Predicted time for  $TASKNOTE :$1  Actual :: $Actual ..  took $COUNTER seconds MORE  on `date` > tmp.log  #
elif [ $COUNTER -gt 60 ]
then
    echo -e "${GREEN} $Percentage MORE predicted time for tasknote $TASKNOTE:$1 Actual ::$Actual .. took $COUNTER secs MORE on `date` ${NC}" 
    echo $Percentage percent LESS Predicting time for $TASKNOTE : $1  Actual :: $Actual ...  took $COUNTER seconds LESS on `date` > tmp.log  # 
else
    echo -e "${PURPLE} $Percentage percent BULLSEYE, Prediction of $2 to require $1 Good Job Sunil on ::  `date` ${NC}" 
    echo $Percentage percent BULLSEYE, Prediction of   $2  to require  $1 Good Job Sunil on  :: `date` > tmp.log  # 
fi

sleep 1

# In the following line -t for timeout, -N for just 1 character
    read -t 0.25 -N 1 input
    if [[ $input = "q" ]] || [[ $input = "Q" ]]; then
# The following line is for the prompt to appear on a new line.
        echo
        break 
    fi
done
