#!/bin/bash 

ARCHIVO=$(/bin/ls -la $1 | awk '{print $9}' | sort -u | tee /tmp/prueba1) 
TOTAL=$(/bin/ls -la | wc -l)
contador=3
if [ -z "$1" ]
then
	echo "spider_output [RUTA]"
else
	until [ $TOTAL -lt $contador ]
	do
		let "contador=$contador+1"
		var=$(awk NR==$contador /tmp/prueba1)
		echo "$var" &
		mkdir "$var"-Result >/dev/null 2>&1 &
		cat $var >/dev/null 2>&1 | grep href | awk '{print $3}' | tee $var-Result/href >/dev/null 2>&1 &
		cat $var >/dev/null 2>&1 | grep subdomains | awk '{print $3}' | tee $var-Result/subdomains  >/dev/null 2>&1 &
		cat $var >/dev/null 2>&1 | grep linkfinder | awk '{print $4}' | tee $var-Result/linkfinder  >/dev/null 2>&1 &
		cat $var >/dev/null 2>&1 | grep javascript | awk '{print $3}' | tee $var-Result/javascript  >/dev/null 2>&1 &
		rm $var >/dev/null 2>&1 &
	done; 
echo "borrando archivos"
rm /tmp/prueba1 &
echo "spider_ouput finish"; exit 1
fi
