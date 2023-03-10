#!/bin/bash

for file in /mnt/c/Users/Cupoooooo/Desktop/admir-smajlovic-devops-mentorship/week3/*
do
if [ -d "$file" ]
then 
echo "$file je direktorij"
elif [ -f "$file" ]
then
echo "$file je fajl"
fi
done