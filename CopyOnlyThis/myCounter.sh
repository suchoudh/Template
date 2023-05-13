#!/usr/bin/bash

COUNTER=$1
TASKNOTE=$2
COUNTER=$(( COUNTER * 60 ))
PREDICTED=$COUNTER
cat tmp.log >> forecast.log   # Concatenate to old logs 
while true
do
	echo $COUNTER seconds remaining in break
	COUNTER=$(( COUNTER - 1 ))
	z=$(($COUNTER / 60))


if [ $COUNTER -lt 0 ]
then
    echo Predicting task  $2  to require  $1 minutes but took $COUNTER seconds MORE $z min  `date` > tmp.log  #
elif [ $COUNTER -gt 0 ]
then
    echo Predicting task  $2  to require  $1 minutes but took $COUNTER seconds or $z min LESS `date` > tmp.log  # 
else
    echo BULLSEYEPrediction of   $2  to require  $1  :: `date` > tmp.log  # 
fi

sleep 1
done

#echo $COUNTER   # both these lines are not shown 
#echo $2  to require this time.$1 deviation was $COUNTER 
