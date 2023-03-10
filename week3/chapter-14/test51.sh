#!/bin/bash

if read -t 5 -p "Unesite svoje ime: " ime
then
echo "Pozdrav $ime, dobrodošli u moju skriptu"
else
echo 
echo "Izvinite previše ste spori"
fi
