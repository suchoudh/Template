COUNTER=$1
TASKNOTE=$2
PREDICTED=$1
COUNTER=$(( COUNTER * 60 ))
touch tmp.log 
cat tmp.log >> forecast.log   # Concatenate to old logs 
cat tmp.log >> $LOGGER/forecast.log   # Concatenate to logger file as well  
while true
do
	echo $COUNTER seconds remaining in $TASKNOTE for mandatory break :: press q/Q to quit
	COUNTER=$(( COUNTER - 1 ))
	z=$(($COUNTER / 60))
	Actual=$(($PREDICTED-$z))   # minus as my z is negative and --=+ 
	Percentage=$((($PREDICTED-$z)*100/$PREDICTED))   # minus as my z is negative and --=+ 
#	echo $Actual
	
if [ $COUNTER -lt -60 ]    # within a min is bulls eye 
then
    echo $Percentage percent MORE Predicted time for  $TASKNOTE :$1  Actual :: $Actual ..  took $COUNTER seconds MORE  on `date` > tmp.log  #
elif [ $COUNTER -gt 60 ]
then
    echo $Percentage percent LESS Predicting time for $TASKNOTE : $1  Actual :: $Actual ...  took $COUNTER seconds LESS on `date` > tmp.log  # 
else
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
