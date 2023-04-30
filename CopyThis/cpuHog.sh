#!/bin/bash
# Script that monitors the top-active process. The script sends an email to the user root if
# utilization of the top active process goed beyond 80%. Of course, this script can be tuned to 
# do anything else in such a case.
#
# Start the script, and it will run forever.

while true
do
	# Check every 60 seconds if we have a process causing high CPU load
	sleep 6
	USAGE=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{ print $1 } '`
	USAGE=${USAGE%.*}
	PID=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{print $2 }'`
	PNAME=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{print $3 }'`

	# Only if we have a high CPU load on one process, run a check within 7 seconds
	# In this check, we should monitor if the process is still that active
	# If that's the case, root gets a message
	if [ $USAGE -gt 80 ] 
	then
		USAGE1=$USAGE
		PID1=$PID
		PNAME1=$PNAME
		sleep 7
		USAGE2=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{ print $1 } '`
		USAGE2=${USAGE2%.*}
		PID2=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{print $2 }'`
		PNAME2=`ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1 | awk '{print $3 }'`
		
		# Now we have variables with the old process information and with the
		# new information
		[ $USAGE2 -gt 80 ] && [ $PID1 = $PID2 ] && mail -s "CPU load of $PNAME is above 80%" root@blah.com < .
	fi
done
