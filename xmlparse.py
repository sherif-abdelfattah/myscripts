import xml.etree.ElementTree as ET
import sys
import urllib as ul
import psycopg2
import hashlib
import re


def doinsert(insertStatement):
    #connecting to the db:
    try:
        connection = psycopg2.connect(user = "atlassian",
                                    password = "atlassian",
                                    host = "127.0.0.1",
                                    port = "5432",
                                    database = "perfdata")
        cursor = connection.cursor()
        # Print PostgreSQL Connection properties
        # print ( connection.get_dsn_parameters(),"\n")
        # Print PostgreSQL version
        # cursor.execute("SELECT * from appxml_data_test")
        # records = cursor.fetchall()
        # for row in records:
        #   print row
        #
        # trying insert:
        cursor.execute(insertStatement)
        connection.commit()
        #
        #
    except (Exception, psycopg2.Error) as error :
        print ("Error while connecting to PostgreSQL", error)
    finally:
        #closing database connection.
            if(connection):
                cursor.close()
                connection.close()
                print("PostgreSQL connection is closed")


def get_bytes(size, suffix):
    size = int(float(size))
    suffix = suffix.lower()

    if suffix == 'k':
        return size << 10
    elif suffix == 'm':
        return size << 20
    elif suffix == 'g':
        return size << 30
    return False

def getint(str):
  return int(re.search(r'\d+', str).group())


tree = ET.parse(sys.argv[1])
root = tree.getroot()
alldatastring=""
osDict={}
databaseDict={}
dataDict={}
#for child in root:
    #print child.tag, child.attrib
# read jvm arguments:
for elem in root.iter("product"):
    #print elem.attrib
    for key,value in elem.attrib.items():
      dataDict[key]=value
      #print key, value
	
for elem in root.iter('virtual-machine-arguments'):
    #print elem.tag,":",elem.text
    dataDict[elem.tag]=elem.text
    tokenized = elem.text.split(" ")
    max_heap=""
    codecache=""
    codecachefound=False
    for strfragment in tokenized:
      if "Xmx" in strfragment:
        max_heap_str=strfragment.split("x")[1]
        max_heap_mult=max_heap_str[len(max_heap_str)-1]
        max_heap_num=max_heap_str[0:len(max_heap_str)-1]
        # print max_heap_num, max_heap_mult
        max_heap=get_bytes(max_heap_num,max_heap_mult)
      if "-XX:ReservedCodeCacheSize=" in strfragment:
	codecachefound=True
        codecache_str=strfragment.split("=")[1]
        codecache_mult=codecache_str[len(codecache_str)-1]
        codecache_num=codecache_str[0:len(codecache_str)-1]
        # print codecache_num, codecache_mult 
        codecache=get_bytes(codecache_num,codecache_mult)
    if codecachefound == False:
	codecache=245000000
    dataDict["max_heap"]=max_heap
    dataDict["codecache"]=codecache
    alldatastring += elem.text

# read OS data:
for elem in root.iter('operating-system'):
  for c in elem.getchildren():
    #print c.tag,":",c.text
    osDict[c.tag]=c.text.replace(',','')
    alldatastring += c.text

# read database stats:
for elem in root.iter('database-statistics'):
    for c in elem.getchildren():
    #print c.tag,":",c.text
      databaseDict[c.tag]=c.text.replace(',','')
      alldatastring += c.text

# read number of plugins:
for elem in root.iter('plugins'):
  #print "Plugins count: ", len(elem.getchildren())
  dataDict["plugin_count"]=len(elem.getchildren())
  alldatastring += str(len(elem.getchildren()))
#for c in elem.getchildren():
#    for d in c.getchildren():
#                  print d.tag,":",d.text

hash_object = hashlib.sha1(bytes(alldatastring))
hex_dig = hash_object.hexdigest()
dataDict["rec_hash"]=hex_dig
#print(hex_dig)

# assemble the data in one dict:
dataDict.update(osDict)
dataDict.update(databaseDict)


# print sorted collected data: 
# for key,value in dataDict.items():
#   print key

#
# Fix for windows unknows
#
for key,value in dataDict.items():
  if type(value) is str and value.lower() in "unknown":
    dataDict[key]="0"    


#
# Fix data for percentages and user/group counts
#
for key in sorted(dataDict):
  if key == "system-cpu-load" or key == "process-cpu-load":
    #print key, float(dataDict[key].replace('%',''))/100.0
    dataDict[key]=float(dataDict[key].replace('%',''))/100.0
  if key == "Users" or key == "Groups":
    #print key, getint(dataDict[key])
    dataDict[key]=getint(dataDict[key])
  #print key,":",dataDict[key]

#
# Build the inster statmenet
# insert into appxmldata ($columns) values ($values)
#
columns=""
values=""
textKeys={'name','os-architecture','os-name','os-version','rec_hash','version','virtual-machine-arguments'}
for key in sorted(dataDict):
  if key == "virtual-machine-arguments":
    dataDict[key]="too long to add"
    values+="'"+str(dataDict[key])+"',"
    columns+="\""+key+"\","
  elif key in textKeys:
    values+="'"+str(dataDict[key])+"',"
    columns+="\""+key+"\","
  else:
    columns+="\""+key+"\","
    values+=str(dataDict[key])+","
print " "
print " "
insertstatement="insert into appxmldata (" + columns.strip(',') + ") values (" + values.strip(',') + ")"
#print insertstatement

doinsert(insertstatement)

