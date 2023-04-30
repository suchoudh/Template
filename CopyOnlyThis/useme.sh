
export DIRNAME="$(date +'%Y_%m_%d_%H_%M')_AUTO"
export DATETAG="$(date +'%Y_%m_%d_%H_%M')"
mkdir $DIRNAME
cp -R ~/Documents/Template/CopyOnlyThis "$DIRNAME"/.
touch "$DIRNAME"/"readme$DATETAG.md"
