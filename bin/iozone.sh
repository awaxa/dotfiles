#!/usr/bin/env bash

TESTS=3

NAME="$1"

for i in {1..$TESTS} ; do
        TIMESTAMP=$(date +%Y.%m.%d.%H%M)
        iozone -R -a -z -b $NAME.$TIMESTAMP.xls -g 8g -f $2/file.test 2>&1 | tee /root/$NAME.$TIMESTAMP.log
done

