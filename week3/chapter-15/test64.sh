#!/bin/bash
#testing lsof with file descriptors

exec 3> test64file1
exec 6> test64file2
exec 7< testfile

/usr/sbin/lsof -a -p $$ -d0,1,2,3,6,7