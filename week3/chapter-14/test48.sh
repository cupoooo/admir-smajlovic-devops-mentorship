#!/bin/bash

read -p "Unesite svoje godine: " godine
days=$[  $godine * 365 ]
echo "To čin preko $days dana"
