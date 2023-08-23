UTC=`date +%s`
>dooTree$UTC.lst
du -h --max-depth=1 >>dooTree$UTC.lst
echo ----------- >> dooTree$UTC.lst
tree -L 3 . >>dooTree$UTC.lst
