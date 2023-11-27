#~~ ~~~~~WeekNumber is 32~~~~~***useme.sh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~   File                : useme.sh 
#~~   Creation DateTime   :32_Tue_20230808-11_24_37
#~~   Last Updated Date   :2023-11-24 Fri 01:06 PM 
#~~   End Date	
#~~   Author              : Sunil Choudhary 
#~~   Remarks             : CopyFilesFromGitorUseDesktopTemplate 
#~~   1: 2023-11-03 Fri 09:03 AM - cd to $DIRNAME as last step  
#a~~  2: 2023-11-24 Fri 12:44 PM - create in day with name as myToday and move to document with older name the offline is yet to be done 
#a~~  3: 2023-11-27 Mon 11:28 AM-- yesterday corrected 
#~~ ~~~~~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#aaaa
#### Set env ###  
. ~/.profile
#export DATETAG="$(date +'%Y_Wk%W_%m_%d_%H_%M_%S')"
export DATETAG="$(date +'%Y_Wk%W_%m_%d')"
export YESTERDAY=`date --date "-1 days"  +"%Y_Wk%W_%m_%d"`
export DATETAG=$YESTERDAY # as myToday is shifted to documents on next day morning and not today 
export DIRNAME=$DATETAG"_myToday"  # myDate is todays date it should be yesterday date ideally. 
export MYTODAY="myToday"

cd ~/    # Run this script from home directory always and not from ~/Desktop/$MYTODAY 

#### Check Net is ( on : copy from github off: copy from template ###  
wget -q --tries=2 --timeout=2 --spider http://google.com
if [[ $? -eq 0 ]]; then
        echo "Online $?--"
	sleep 2 	


	echo "Cleanup files you do not need ..." 
	sleep 2 
#	cd 2023*  # this is the existing dir which is one day old
#	rm CopyMe.sh
#	rm -rf CopyOnlyThis
#	rm -rf CopyThis
#	rm CornellTemplate.ott
#	rm LICENSE
#	rm makeTree.sh
#	rm myCounter.sh
#	rm useme.sh
#	rm warikoo2023_06_08_14_16_48.ods
#	rm welcome.txt
	
	echo "Flush the last tmp etc..." 
	sleep 2 
	cat tmp.log >>forecast.log # this flushes the last entry 
	echo "====LAST FLUSH====" >> forecast.log
	cd ~/Desktop  # get back to desktop 
#	mv 2023* ~/Documents/
	echo $DIRNAME
	mv $MYTODAY ~/Documents/$DIRNAME
	mv Template* ~/Documents/    # Flush  older template to documents as new is getting downloaded.  

	git clone https://www.github.com/suchoudh/Template.git 
	sleep 2
	cp -r Template ~/Desktop/Template$DATETAG
	mv Template $MYTODAY
	touch "$MYTODAY"/"readme$DATETAG.md"
	mv $MYTODAY/CopyOnlyThis/warikoToday.ods $MYTODAY/warikoo$DATETAG.ods
	mv $MYTODAY/CopyOnlyThis/myCounter.sh $MYTODAY
	mv $MYTODAY/CopyOnlyThis/CornellTemplate.ott $MYTODAY
	cat "$MYTODAY"/"CopyOnlyThis"/"readmeClone.md" >> "$MYTODAY"/"readme$DATETAG.md"  
# --------------------------------------------------------------
else
        echo "you appear to be Offline .. Copying from Template"  # Use Template if Offline 
	cd ~/Desktop
	mv 2023* ~/Documents/    # cleanup older to documents folder. 
	export DATETAG="$(date +'%Y_%m_%d_%H_%M_%S')"
	export DIRNAME="$(date +'%Y_%m_%d_%H_%M_%S')_Offline"
	cp -r ~/Desktop/Template* ~/Desktop/$DIRNAME   # Copy from latest Template # What happens when there are more Template_DATE files ?? TBD 
#	mkdir $DIRNAME   # Not needed 
	touch "$DIRNAME"/"readme$DATETAG.md"
	mv $DIRNAME/CopyOnlyThis/warikoToday.ods $DIRNAME/warikoo$DATETAG.ods
	mv $DIRNAME/CopyOnlyThis/myCounter.sh $DIRNAME
	mv $DIRNAME/CopyOnlyThis/CornellTemplate.ott $DIRNAME
	cat "$DIRNAME"/"CopyOnlyThis"/"readmeClone.md" >> "$DIRNAME"/"readme$DATETAG.md"  
fi

	cd ~/Desktop/$MYTODAY

echo BoD HighMark was 
cat /home/rahu/Desktop/Dropbox/3400_Routine/myData/_BoD/BoD.HighMark
#~~ Ran on 32_Tue_20230808-11_24_37
