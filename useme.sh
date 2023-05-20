export DATETAG="$(date +'%Y_%m_%d_%H_%M_%S')"

export DIRNAME="$(date +'%Y_%m_%d_%H_%M_%S')_Lenovo"

git clone https://www.github.com/suchoudh/Template.git 
sleep 2
mv Template $DIRNAME
touch "$DIRNAME"/"readme$DATETAG.md"
mv $DIRNAME/CopyOnlyThis/warikoToday.ods $DIRNAME/warikoo$DATETAG.ods
mv $DIRNAME/CopyOnlyThis/myCounter.sh $DIRNAME
mv $DIRNAME/CopyOnlyThis/CornellTemplate.ott $DIRNAME
rm $DIRNAME/CopyThis
cat "$DIRNAME"/"CopyOnlyThis"/"readmeClone.md" >> "$DIRNAME"/"readme$DATETAG.md"  
