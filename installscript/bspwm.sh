#!/bin/bash

echo ""
echo "██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗
██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║
██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║
██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║
██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║
╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝"
echo ""

sudo pacman -Syyu

echo "#### Installing yay ####"
git clone https://aur.archlinux.org/yay.git
cd ~/yay
makepkg -si

curl http://sprunge.us/H57uZl > ~/.xinitrc

cd ~/
git clone https://github.com/aayushrathor/dotfiles 
cd dotfiles
yay -S - < packages

cd ~/dotfiles/configs
stow * /

cd ~/dotfiles/script
stow * /

chmod +x ~/.config/bspwm/bspwmrc 
chmod +x ~/.config/sxhkd/sxhkdrc 

