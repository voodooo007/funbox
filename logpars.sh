#!/bin/bash
#Script for counting NOK events

NAMESCRIPT="${0##*/}"

function  check_input_params ()
{
    if [ "$PARAM" == "" ]
    then
        echo "usage: $NAMESCRIPT <log_file>"
	exit 1
    fi
}

PARAM=$1
check_input_params

if [ ! -e "$1" ]
then
    echo "ERROR: LOG file not found"
    exit 1
fi

FILE=$1
TEMPFILE="$(mktemp)"
TEMPFILE2="$(mktemp)" 

grep "NOK" $FILE > $TEMPFILE
awk '{print $1 " " $2}' $TEMPFILE | tr -d "[]" |  rev | cut -c 4- | rev > $TEMPFILE2
cat  $TEMPFILE2 | uniq -c | sort -r
rm $TEMPFILE $TEMPFILE2

