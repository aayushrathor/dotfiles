#!/bin/bash

killall conky
sleep 2s

conky -c $HOME/.config/conky/Lesath/Lesath.conf &> /dev/null &
