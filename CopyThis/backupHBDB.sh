#~~ ~~~~~WeekNumber is 41~~~~~***backupHBDB.sh ~~~~~~~~~~~~~~~~~~
#~~   File                : backupHBDB.sh 
#~~   Creation DateTime   :41_20221015-05_20
#~~   Last Updated Date   :41_20221015-05_20 
#~~   End Date	
#~~   Author              : Sunil Choudhary 
#~~   Remarks             :  
#~~                              1) the delme.log is now updated in _log folder as created by mvImages alias of 2hb 
#~~ ~~~~~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#aaaa 
# This one run at midnight. 
# Is there  a way to use less CPU and more time. 

cd /home/rahu
notify-send -t 200 "Starting Backup  .. " -u critical
#sleep 240
#script $LOGGER/UTC_$UTC_$WK_DATE_TIME.log
echo Start$WK_DATE_TIME >>_log/.log
export UTC=`date +%s`
echo "bckup Hbox Start$UTC" >>_log/HBox$UTC.log # start 
#tar -cvzf HomeboxUTC$UTC.tar /home/rahu/Homebox/ >HomeboxUTC$UTC.log&
sleep 5 
echo endsHBox$UTC >>_log/HBox$UTC.log  # end HBox 
sleep 5 
export UTC=`date +%s`
echo "bckup Dbox Start$UTC" >>_log/DBox$UTC.log # start 
export UTC=`date +%s`
tar -cvf DropboxUTC$UTC.tar Dropbox/ >DropboxUTC$UTC.log&
echo endsDBox$UTC >>_log/DBox$UTC.log   # end DBox 
notify-send -t 200 "Backup  ..Finished  " -u critical
#~~ Ran on 41_20221015-05_20
