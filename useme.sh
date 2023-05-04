export DATETAG="$(date +'%Y_%m_%d_%H_%M')"
export DIRNAME=$DATETAG"_AUTO"
echo $DIRNAME
mkdir $DIRNAME
cp -R ~/Documents/Template/CopyOnlyThis "$DIRNAME"/.
touch "$DIRNAME"/"readme$DATETAG.md"
cat ~/Documents/Template/CopyOnlyThis/readmeDOLLARDATETAG.md >>$DIRNAME/"readme$DATETAG.md"
