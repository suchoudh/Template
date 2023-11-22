#~~ ~~~~~WeekNumber is 47~~~~~***taskBirdEye.sh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~   File                : taskBirdEye.sh 
#~~   Creation DateTime   :47_Thu_20231123-01_10_39
#~~   Last Updated Date   :47_Thu_20231123-01_10_39 
#~~   End Date	
#~~   Author              : Sunil Choudhary 
#~~   Remarks             : StandAloneScript Only change the first line in script for project name and it will give the output without affecting readme_2Area.md file  
#~~                              1) This is first point 
#~~ ~~~~~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#aaaa 
result=${PWD##*/}.Test 
echo $result 
#project=4Archive.Travel
project=${PWD##*/}   # the folder name in which the file is is taken as the project name to run the task and readme files 
> taskw_$project.md  # erase file 
touch -a readme_$project.md # touch and create if not existing. ( do not disturb modification time but only access time and change time  if already exists) 
	echo "----------------WeeklyBurnDown $project --------------" >>taskw_$project.md  
	task burndown.weekly pro:$project  >> taskw_$project.md;
	echo "----------------Summary  $project --------------" >>taskw_$project.md
	task project pro:$project summary >>taskw_$project.md;
	echo "----------------SimpleList $project --------------" >>taskw_$project.md
	task project pro:$project simple >>taskw_$project.md;
	
	echo '----$WK_DAY_DATE_TIME------------High Priority --------------' >>taskw_$project.md
	task project pro:$project pri:H simple  >> taskw_$project.md;
	echo '----------------Medium Priority --------------' >>taskw_$project.md
	task project pro:$project pri:M simple  >> taskw_$project.md;
	echo '----------------Low Priority --------------' >>taskw_$project.md
	task project pro:$project pri:L simple  >> taskw_$project.md;
	echo '----------------No Priority --------------' >>taskw_$project.md
	task project pro:$project pri: simple  >> taskw_$project.md;
	echo '----------------Done on ' $WK_DAY_DATE_TIME '--------------' >>taskw_$project.md
#~~ Ran on 47_Thu_20231123-01_10_39
