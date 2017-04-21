# Easy screenshot

## Operating system support
- Linux (has been tested on Debian Jessie)

## Prerequisites
- xclip (clipboard tool)
- rsync (transfer tool) (only if MOVE_COMMAND is set to rsync)
- import (screenshot tool) (only if CAPTURE_SELECTION_COMMAND is set to import)

## Installation
1/ Clone this repository:
```
cd ~
mkdir easy-screenshot
git clone https://github.com/shinbuntu/easy-screenshot.git easy-screenshot
```
2/ Copy the config file:
```
cd easy-screenshot && cp screenshot.example.conf screenshot.conf
```
3/ Edit it.

Parameter                   | Description                       | Additional help                                                    | Examples                                                                            
--------------------------- | --------------------------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------------------------
DESTINATION                 | Save location of screen shots     | You can use a path, or ssh path if you use rsync as move command   | "/sshfs/destination_screenshot/" or "screenshot@example.com:/home/screenshot/http" 
MOVE_COMMAND                | The command to move screen shot   | You can use mv, rsync, ...                                         | "rsync -az --chmod=+r" or "mv"                                                     
CAPTURE_SELECTION_COMMAND   | The screen shot command           |                                                                    | "import -frame"                                                                   
URL                         | The base url of screen shots      |                                                                    | "https://screenshot.example.fr"                                                   

4/ Bind a keyboard shortcut
Use the full path, you can get it by: 
```
realpath ~/easy-screenshot/run.sh
```

For animation gif, add --gif --window after the command and bind another keyboard shortcut.