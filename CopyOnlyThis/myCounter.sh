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
    echo Predicting task  $2  to require  $1 minutes but took $COUNTER seconds more `date` > tmp.log  # tmp.log contains last entry
    sleep 1
done

#echo $COUNTER   # both these lines are not shown 
#echo $2  to require this time.$1 deviation was $COUNTER 
