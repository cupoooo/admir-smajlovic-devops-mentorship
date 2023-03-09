#!/bin/bash

var1=100

until echo $var1
        [ $var1 -eq 0 ]
do
    echo Unutar petlje: $var1
    var1=$[ $var1 - 25]
done