#!/usr/bin/bash
# Enter how much time you will need to complete the task in hand 
# when you come back to stop it see how far off is your estimate. 
# Did you do the work in specefied time or did you need less or more minutes 
# Get this forecasting power right .. this will be a superpower for you in using the pomodoro technique
# 20 min work 5 min MANDATORY break and there can be time when you are niether on break NOR on a task and that is OK too. 
COUNTER=$1
COUNTER=$(( COUNTER * 60 ))

while true
do
	echo $COUNTER seconds remaining in break
	COUNTER=$(( COUNTER - 1 ))
	sleep 1
done
