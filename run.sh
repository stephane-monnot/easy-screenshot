#!/bin/bash

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$PWD"

if [ -f "./screenshot.conf" ]
then
    source "./screenshot.conf"
else
    echo "screenshot.conf: No such file."
    exit 255
fi

FILENAME="$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1).png"

#gnome-screenshot -a -f "$DESTINATION/$FILENAME"
TMPFILE="$(mktemp).png";

CAPTURE_SELECTION_CMD="$CAPTURE_SELECTION_COMMAND $TMPFILE"
$CAPTURE_SELECTION_CMD

MOVE_CMD="$MOVE_COMMAND $TMPFILE $DESTINATION/$FILENAME"
$MOVE_CMD

rm "$TMPFILE"

echo "$URL/$FILENAME" | xclip -selection c