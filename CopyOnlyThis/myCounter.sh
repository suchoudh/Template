RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

#Region --- Updates
#    echo -e "${PURPLE}RUNNING: sudo apt update --fix-missing${NC}"




COUNTER=$1
TASKNOTE=$2
PREDICTED=$1
COUNTER=$(( COUNTER * 60 ))
touch tmp.log 
cat tmp.log >> forecast.log   # Concatenate to old logs 
cat tmp.log >> $LOGGER/forecast.log   # Concatenate to logger file as well  
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
    echo -e "${RED} $Percentage % elapsed time for TASK $TASKNOTE. Used $Actual minutes MORE from Allocated $1 minutes.. took $COUNTER secs MORE on `date` ${NC}" 
    echo $Percentage percent MORE Predicted time for  $TASKNOTE :$1  Actual :: $Actual ..  took $COUNTER seconds MORE  on `date` > tmp.log  #
elif [ $COUNTER -gt 60 ]
then
    echo -e "${GREEN} $Percentage % elapsed time  for Task $TASKNOTE. Used $Actual minutes of Allocated ::$1 minutes..took $COUNTER secs LESS on `date` ${NC}" 
    echo $Percentage percent LESS Predicting time for $TASKNOTE : $1  Actual :: $Actual ...  took $COUNTER seconds LESS on `date` > tmp.log  # 
else
    echo -e "${PURPLE} $Percentage % elapsed time for Task $TASKNOTE. Used $Actual  minutes of Allocated $1 minutes .. Good Job Sunil  on ::  `date` ${NC}" 
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
