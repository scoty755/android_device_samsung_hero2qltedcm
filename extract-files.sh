#!/bin/bash

VENDOR=samsung
DEVICE=hero2qltedcm

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*
# rm log_print.txt
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$ `; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
    # cp ~/WorkDir/SC02H/system/$FILE $BASE/$FILE 2>> log_print.txt
done

./setup-makefiles.sh
