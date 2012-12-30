#!/usr/bin/env bash

NAME="$1"
MOUNT="$2"

TESTS=1

mkdir -p $NAME

for i in {1..$TESTS} ; do
        TIMESTAMP=$(date +%Y.%m.%d.%H%M)
        iozone -R -a -z -b $NAME.$TIMESTAMP.xls -g 2g -f $MOUNT/file.test 2>&1 | tee $NAME/$NAME.$TIMESTAMP.log
        rm -f $MOUNT/file.test
done

