#!/bin/bash

exec 3>&1
exec 1>test60out

echo "This should store in the output file"
echo "along with this line"

exec 1>&3

echo "now thing should be back to normal"