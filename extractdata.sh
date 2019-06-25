##
# extracts xml data out of application.xml
# Using shell script commands.
##
#set -x

# get product xml
product=$(grep -n "<product " ${1}|cut -d":" -f1)


# get virtual machine args:
vm_args=$(grep -n "virtual-machine-arguments>" ${1}|cut -d":" -f1)




# get operating-system data:
os_s=$(grep -n "<operating-system>" ${1}|head -1|cut -d":" -f1)
os_e=$(grep -n "</operating-system>" ${1}|tail -1|cut -d":" -f1)




# get database-statistics data:
database_s=$(grep -n "<database-statistics>" ${1}|head -1|cut -d":" -f1)
database_e=$(grep -n "</database-statistics>" ${1}|tail -1|cut -d":" -f1)




# get Plugins data:
plugins_s=$(grep -n "<plugins>" ${1}|head -1|cut -d":" -f1)
plugins_e=$(grep -n "</plugins>" ${1}|tail -1|cut -d":" -f1)

cat ${1}|head -1
echo "<xmlextract>"
#echo $product
sed -n "${product},${product}p" ${1}
#echo $vm_args
sed -n "${vm_args},${vm_args}p" ${1}
#echo $os_s
#echo $os_e
sed -n "${os_s},${os_e}p" ${1}
#echo $database_s
#echo $database_e
sed -n "${database_s},${database_e}p" ${1}
#echo $plugins_s
#echo $plugins_e
sed -n "${plugins_s},${plugins_e}p" ${1}
echo "</xmlextract>"
