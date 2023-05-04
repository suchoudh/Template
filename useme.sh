export DATETAG="$(date +'%Y_%m_%d_%H_%M')"
export DIRNAME=$DATETAG"_AUTOv1"
echo $DIRNAME
mkdir $DIRNAME
cp -R ~/Documents/Template/CopyOnlyThis "$DIRNAME"/.
touch "$DIRNAME"/"readme$DATETAG.md"
cat ~/Documents/Template/CopyOnlyThis/readmeClone.md >>$DIRNAME/"readme$DATETAG.md"
