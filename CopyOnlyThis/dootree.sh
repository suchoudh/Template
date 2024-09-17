#~~ ~~~~~WeekNumber is 31~~~~~***dootree.sh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~   File                : dootree.sh 
#~~   Creation DateTime   :31_Sun_20230806-22_37_00
#~~   Last Updated Date   :31_Sun_20230806-22_37_00 
#~~   End Date	
#~~   Author              : Sunil Choudhary 
#~~   Remarks             : CreateAMapStructureAlongWithSizeofMainFOlders 
#~~                              1) This is first point 
#~~ ~~~~~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#aaaa 
UTC=`date +%s`
>myMap$UTC.lst
echo ----Current Directory------- >> myMap$UTC.lst
pwd >>myMap$UTC.lst
echo ----Space used ------- >> myMap$UTC.lst
du -h --max-depth=1 >>myMap$UTC.lst
echo -----Dir Structure------ >> myMap$UTC.lst
tree -L 3 . >>myMap$UTC.lst
#~~ Ran on 31_Sun_20230806-22_37_00
