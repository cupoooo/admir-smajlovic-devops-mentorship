#!/bin/bash

for (( a = 1; a < 4; a++ ))
do
echo "Vanjska petlja: $a"
for (( b = 1; b < 100; b++ ))
do
if [ $b -eq 5 ]
then
break
fi
echo "Unutrašnja petlja: $b"
done
done
