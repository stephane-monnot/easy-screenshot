#!/bin/bash
#byzanz-record-window
#dependency checks
if ! which xwininfo &>/dev/null;  then
    echo "Dependency xwininfo not met."
    deps_ok=NO
fi

if ! which byzanz-record &>/dev/null;  then
    echo "Dependency byzanz not met."
    deps_ok=NO
fi

if [[ $deps_ok == NO ]]; then
    echo "Please install the needed dependencies any try again."
    exit 1
fi

#get stuff from xwininfo
xwininfo=$(xwininfo -shape)

getnum()
{
    echo "$xwininfo" | grep "$1" | tr -cd [:digit:]
}

x=$(getnum "Absolute upper-left X:")
y=$(getnum "Absolute upper-left Y:")
w=$(getnum "Width:")
h=$(getnum "Height:")

#record
byzanz-record $@ -x $x -y $y -w $w -h $h 
