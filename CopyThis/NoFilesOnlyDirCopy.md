rsync -av -f"+ */" -f"- *" "/path/to/the/source/rootDir" "/tmp/test"

tree -a rootDir 


Option 2 

find rootDir -type d -exec mkdir -p "/tmp/test/{}" \;

Option 2a (using xargs)
find rootDir -type d | xargs -I{} mkdir -p "/tmp/test/{}"


Option 3 
tree -dfi --noreport rootDir | xargs -I{} mkdir -p "/tmp/test/{}"

tree -dfi --noreport rootDir

