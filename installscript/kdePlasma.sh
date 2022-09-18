#!/bin/bash

echo "#### Updating system ####"
sudo pacman -Syy

sudo pacman -S xorg xorg-xinit plasma kde-applications sddm firefox

sudo systemctl enable sddm

/bin/echo -e "\e[1;32mREBOOTING IN 5..4..3..2..1..\e[0m"
sleep 5
