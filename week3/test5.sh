#!/bin/bash
# čitanje vrijednosti iz fajla

file="gradovi"

for grad in $(cat $file)
do 
echo "Posjeti prelijepi $grad"
done