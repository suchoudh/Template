export DATETAG="$(date +'%Y_%m_%d_%H_%M_%S')"

export DIRNAME="$(date +'%Y_%m_%d_%H_%M_%S')_AUTO"

git clone https://www.github.com/suchoudh/Template.git 
mv Template $DIRNAME
touch "$DIRNAME"/"readme$DATETAG.md"
cat "$DIRNAME"/"CopyOnlyThis"/"readmeClone.md" >> "$DIRNAME"/"readme$DATETAG.md"  
