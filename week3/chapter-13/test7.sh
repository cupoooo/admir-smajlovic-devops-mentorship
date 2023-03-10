#!/bin/bash

for file in /mnt/c/Users/Cupoooooo/Desktop/admir-smajlovic-devops-mentorship/week3/* /mnt/c/Users/Cupoooooo/Desktop/admir-smajlovic-devops-mentorship/week3/admir
do
if [ -d "$file" ]
then 
echo "$file je direktorij"
elif [ -f "$file" ]
then
echo "$file je fajl"
else
echo "$file ne postoji"
fi
done