#!/bin/bash
#testing closing file descriptions

exec 3> test63file
echo "This is a test line of data" >&3
exec 3>&-

cat test63file
exec 3> test63file
echo "This will be bad" >&3
