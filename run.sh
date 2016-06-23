#!/bin/bash

PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$PWD"
echo "$PWD"

if [ -f "./screenshot.conf" ]
then
    source "./screenshot.conf"
else
    echo "screenshot.conf: No such file."
    exit 255
fi

FILENAME="$(tr -cd '[:alnum:]' < /dev/urandom | fold -w30 | head -n1).png"

#gnome-screenshot -a -f "$DESTINATION/$FILENAME"
import -frame "$DESTINATION/$FILENAME"


echo "$URL/$FILENAME" | xclip -selection c


