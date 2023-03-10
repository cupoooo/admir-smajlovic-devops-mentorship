#!/bin/bash

read -n1 -p "Da li želite da nastavite [Y/N]? " odgovor
case $odgovor in
Y | y) echo
       echo "dobro, nastavljamo";;
N | n) echo 
       echo OK, doviđenja
       exit;;
esac
echo "Ovo je kraj skripte"
