#!/bin/bash

var1=1

while [ $var1 -lt 10 ]
do 
if [ $var1 -eq 5 ]
then
break
fi
echo "Iteracija: $var1"
var1=$[ $var1 + 1 ]
done
echo "While petlja je završena"