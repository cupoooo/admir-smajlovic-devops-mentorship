#!/bin/bash
# čitanje vrijednosti iz fajla

file="gradovi"
IFS=$'\n'
for grad in $(cat $file)
do
echo "Posjeti prelijepi $grad"
done