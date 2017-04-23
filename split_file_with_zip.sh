
# 2016.02.23 

# step 1. tar files together
zip google.zip google_doc.txt yahoo.txt

# step 2. split the zip file  separately,if the size of file less than 4,then 1 file only;
#  if bigger than 4 like 5,will 2 files;if much more bigger like 9 ,will 3 files...
zip -s 4m google.zip --out ziptest

# step 3. together files 
cat ziptest.* > google_bak.zip 

# step 4. unzip files
unzip google_bak.zip

