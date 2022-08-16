#!/bin/sh

cat ~/Desktop/pat.txt | xclip -selection clipboard && notify-send -u NORMAL --icon=dialog-information 'GitPat Copied to clipboard'
