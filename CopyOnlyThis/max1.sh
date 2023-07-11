#!/bin/bash
# there is a highwatermark in BoD.highMark of 50
# you enter a value for last day 
# if its higher than 50 you updte this in BoD.highMark 
# if its lowr do nothing 
# show the value of last high mark 


HighMark=50 
file=BoD.highMark  # this file contains only one entry like 50 or 80 and nothing else 
HighMark=$(<"$file") 
#HighMark=50 

echo enter marks out of 100 
read currentMark 

if [ $currentMark -gt $HighMark ]     
then
    echo $currentMark >$file  # $HighMarks # > tmp.log  #
elif [ $currentMark -lt $HighMark ]
then
    echo Try Harder Soldier   # $currentMark #  > tmp.log  # 
else
    echo NoChange Pretty Boy  # > tmp.log  # 
fi



