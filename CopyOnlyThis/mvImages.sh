#~~ ~~~~~WeekNumber is 30~~~~~***mvImages.sh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~   File                : mvImages.sh 
#~~   Creation DateTime   :30_20210726-15_38
#~~   Last Updated Date   :2022-11-09 Wed 09:43 PM 
#~~   End Date	
#~~   Author              : Sunil Choudhary 
#~~   Remarks             :  Move images docs pdfs md file vids etc to _<name> folders  
#~~                              1) This is first point 
#~~      2022-11-09 Wed 09:43 PM 2) added log folder _logs to move *.log files to _log folder and delete _log folder if it does not have any files in it. 
#~~ ~~~~~~~~111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Create folders only if the files exist otherwise do not create folder 
#Remove folders which are empty ask before deletion. 

# Making directories. ## Write code so it does not error out if folders exist. 
mkdir _md 
mkdir _img 
mkdir _vid
mkdir _pdf_doc_odt_pptx
mkdir _tar_zip_gz
mkdir _sh
mkdir _log 

# read "this will convert spaces in file and folders to _ Do you want to proceed ? "   # 2023-05-27 Sat 02:39 PM

# Remove all the spaces from directories (First) and then filenames
# Also remove the , to _ in filenames 
#echo " Removing , to _ in directories and then in filenames " 
#sleep 2 
find . -name "* *" -type d | rename 's/ /_/g'    # do the directories first
find . -name "* *" -type f | rename 's/ /_/g'
#find . -name "*,*" -type f | rename 's/,/_/g'  # find , and insert_ it as some pics have this comma What happens to my zing files need to be seen  




# Moving files to respective folder 
mv *.md _md/. 

mv *.jpg _img/.
mv *.gif _img/.
mv *.webp _img/.
mv *.webm _img/.
mv *.png _img/.
mv *.jpeg _img/.
mv *.svg _img/.
mv *.psd _img/.

mv *.mp4 _vid/.
mv *.mp3 _vid/.  # Audio is also copied there itself 
mv *.mkv _vid/.
mv *.mov _vid/.

mv *.pdf _pdf_doc_odt_pptx/.
mv *.doc _pdf_doc_odt_pptx/.
mv *.odt _pdf_doc_odt_pptx/.
mv *.pptx _pdf_doc_odt_pptx/.
mv *.pages _pdf_doc_odt_pptx/.
mv *.docx _pdf_doc_odt_pptx/.

mv *.tar _tar_zip_gz/.
mv *.zip _tar_zip_gz/.
mv *.gz _tar_zip_gz/.

mv *.log _log/.

# Copying sh files so things do not break 2021-07-26 Mon 04:04 PM
cp *.sh _sh/.
dir
# Listing empty directories 
echo ++++++++++++ List of Empty Directories ++++++++
find . -empty/ -maxdepth 1
echo +++++++++++++++++++++++++++++++++++++++++++++++ 
read -p "Any folder other than img,vid,pdf,doc,md,tar_zip,zip,sh will not be deleted... " 
# Delete Empty folders created in initialisation  
find _img -depth -type d -empty -delete
find _vid -depth -type d -empty -delete
find _pdf -depth -type d -empty -delete
find _pdf_doc_odt_pptx -depth -type d -empty -delete
find _doc -depth -type d -empty -delete
find _md -depth -type d -empty -delete
find _tar_zip_gz -depth -type d -empty -delete
find _sh -depth -type d -empty -delete
find _log -depth -type d -empty -delete

echo moved images to _img and vids to _vid 
echo ----- 
echo 'List of Empty folders currently untouched.'
echo -----  
find . -type d -empty 
#~~ Ran on 30_20210726-15_34
#~~ Ran on 30_20210726-15_38
