#!/bin/bash

for (( a = 1; a <= 3; a++ ))
do 
echo "Početak petlje $a:"
for (( b = 1; b <= 3; b++ ))
do
echo "  Unutar petlje: $b"
done
done