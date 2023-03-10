#!/bin/bash

count=1
cat test54.txt | while read line
do 
echo "Line $count: $line"
count=$[ $count + 1 ]
done
echo "Finished processing the file"