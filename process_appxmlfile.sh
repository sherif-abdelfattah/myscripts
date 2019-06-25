#
#
#

# extracting the data:
bash extractdata.sh ${1} > /tmp/extract.xml

# adding to database:
python xmlparse.py /tmp/extract.xml 

echo "Done"
