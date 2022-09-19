#!/bin/bash

#script is for intel users so if you have amd processor then change intel drivers by amd ones

#echo "#### Ensure partitions are created, formated and mounted Before ####"

echo ""
echo "██████╗  █████╗ ███████╗███████╗  ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     "
echo "██╔══██╗██╔══██╗██╔════╝██╔════╝  ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     "
echo "██████╔╝███████║███████╗█████╗    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     "
echo "██╔══██╗██╔══██║╚════██║██╔══╝    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     "
echo "██████╔╝██║  ██║███████║███████╗  ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗"
echo "╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝"
echo ""

#pacstrap
#pacstrap /mnt base base-devel linux linux-headers linux-firmware vim intel-ucode git

# fstab
#genfstab -U /mnt >> /mnt/etc/fstab
#cat /mnt/etc/fstab

#arch chroot
arch-chroot /mnt

#locales
echo "#### TimeZone is set to India ####"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

echo "#### Uncomment 'en_US.UTF-8 UTF-8' ####"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
export LANG=en_US.UTF-8

#hostname
echo "#### Enter Hostname ####"
read hostname
echo "Hostname: $hostname"
echo $hostname >> /etc/hostname

echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1		$hostname.localdomain	$hostname" >> /etc/hosts
cat /etc/hosts

#set root password
echo "#### Set Root Password ####"
passwd
echo "#### Successfully created root password ####"

#grub
echo "#### Installing some base packages ####"
pacman -S grub efibootmgr os-prober ntfs-3g networkmanager network-manager-applet wireless_tools wpa_supplicant dialog mtools dosfstools nano

echo "#### Installing grub ####"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
grub-mkconfig -o /boot/grub/grub.cfg

#enable services
echo "#### enable services ####"
systemctl enable NetworkManager

#create user
echo "#### Enter Username ####"
read arch_username
useradd -m $arch_username
usermod -aG wheel $arch_username

echo "#### Enter password ####"
passwd $arch_username

#set text editor
echo "#### Uncomment '%wheel ALL=(ALL:ALL) ALL' ####"

echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers.tmp
#EDITOR=vim visudo

#install success
#echo "#### Base Install Success ####"
printf "\e[1;32mDone! Type exit umount -lR /mnt and reboot"
sleep 3
exit
