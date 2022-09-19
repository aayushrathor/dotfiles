#!/bin/bash

echo ""
echo "██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗
██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║
██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║
██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║
██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║
╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝"
echo ""

echo "#### mirrooooooors ####"
sudo pacman -S reflector
sudo reflector --latest 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist 

sudo pacman -Syyu

echo "#### Installing yay ####"
cd ~/
git clone https://aur.archlinux.org/yay.git
cd ~/yay
makepkg -si

echo "#### .xinitrc ####"
curl http://sprunge.us/H57uZl > ~/.xinitrc

echo "#### Installing Packages ####"
cd ~/
git clone https://github.com/aayushrathor/dotfiles 
cd dotfiles
yay -S - < packages

echo "#### stow dotfiles ####"
cd ~/dotfiles/configs
stow * /

cd ~/dotfiles/script
stow * /

chmod +x ~/.config/bspwm/bspwmrc 
chmod +x ~/.config/sxhkd/sxhkdrc 

echo "<<<<---- Install Success! ---->>>>"
