#!/bin/bash

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$PWD"

# Options
PARSED_OPTIONS=$(getopt -n "$0"  -o gw --long "gif,window"  -- "$@")

eval set -- "$PARSED_OPTIONS"

GIF=0;
WINDOW=0;
while true;
do
  case "$1" in
    -g|--gif)
        GIF=1;
        shift
    ;;
    -w|--window)
        WINDOW=1;
        shift
    ;;
    --)
        shift
        break
    ;;
  esac
done

if [ -f "./screenshot.conf" ]
then
    source "./screenshot.conf"
else
    echo "screenshot.conf: No such file."
    exit 255
fi

#FILENAME="$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1)"
FILENAME=$(head -100 /dev/urandom | tr -cd '[:alnum:]' | fold -w30 | head -n1)

if [ $GIF == 1 ]
then
    FILENAME="$FILENAME.gif"
    TMPFILE="$(mktemp).gif"
    if [ $WINDOW == 1 ]
    then
        # If byzanz-record is running, it kill him and just move the file
        PID=$(ps -A | grep "byzanz-record$" | grep -v grep | awk '{print $1}')
        if [ "$PID" != "" ]
        then
            kill $PID
            CAPTURE_CMD=""
        else
            CAPTURE_CMD="$CAPTURE_GIF_WINDOW_COMMAND $TMPFILE"
        fi
    fi
else
    FILENAME="$FILENAME.png"
    TMPFILE="$(mktemp).png"
    CAPTURE_CMD="$CAPTURE_SELECTION_COMMAND $TMPFILE"
fi

#gnome-screenshot -a -f "$DESTINATION/$FILENAME"
$CAPTURE_CMD

MOVE_CMD="$MOVE_COMMAND $TMPFILE $DESTINATION/$FILENAME"
$MOVE_CMD

rm "$TMPFILE"

echo "$URL/$FILENAME" | xclip -selection c