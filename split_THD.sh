set -x
#
#
#
#
#


FILE=$1

STARTLINE=(`grep -n "Full thread dump Java HotSpot(TM)" ${FILE} |cut -d":" -f1`)
ENDLINE=(`grep -n "JNI global references" ${FILE} |cut -d":" -f1`)

for ((i=0;i<${#STARTLINE[@]};i++))
do
        tail -n +$((${STARTLINE[$i]} - 1)) ${FILE} | head -n $((${ENDLINE[$i]} - ${STARTLINE[$i]} + 8)) >thd_${i}
done
