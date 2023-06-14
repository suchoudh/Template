cd 2023*
rm CopyMe.sh
rm -rf CopyOnlyThis
rm -rf CopyThis
rm CornellTemplate.ott
rm LICENSE
rm makeTree.sh
#rm myCounter.sh
readme2023_06_08_14_16_48.md
#rm useme.sh
rm warikoo2023_06_08_14_16_48.ods
rm welcome.txt
cat tmp.log >>forecast.log # this flushes the last entry 
cd ~/Desktop  # get back to desktop 
mv 2023* ~/Documents/
export DATETAG="$(date +'%Y_%m_%d_%H_%M_%S')"
export DIRNAME="$(date +'%Y_%m_%d_%H_%M_%S')_Lenovo"

git clone https://www.github.com/suchoudh/Template.git 
sleep 2
mv Template $DIRNAME
touch "$DIRNAME"/"readme$DATETAG.md"
mv $DIRNAME/CopyOnlyThis/warikoToday.ods $DIRNAME/warikoo$DATETAG.ods
mv $DIRNAME/CopyOnlyThis/myCounter.sh $DIRNAME
mv $DIRNAME/CopyOnlyThis/CornellTemplate.ott $DIRNAME
cat "$DIRNAME"/"CopyOnlyThis"/"readmeClone.md" >> "$DIRNAME"/"readme$DATETAG.md"  
