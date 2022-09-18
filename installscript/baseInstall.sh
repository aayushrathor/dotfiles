#!/bin/bash

#script is for intel users so if you have amd processor then change intel drivers by amd ones

echo "#### Ensure partitions are created, formated and mounted Before ####"

echo "#### Base Installation ####"

echo "#### which processor does you have ####\n amd\t\tintel\n enter amd or intel either"
read driver

if [[ $driver -eq "amd" ]]
then
	$findriver = "amd-ucode"
elif [[ $driver -eq "intel" ]]
then
	$findriver = "intel-ucode"
else
	echo "enter correct driver"
	$findriver = ""
fi

#pacstrap
pacstrap /mnt base base-devel linux linux-headers linux-firmware vim $findriver git

# fstab
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

#arch chroot
arch-chroot /mnt

#locales
echo "#### TimeZone is set to India ####"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

echo "#### Uncomment 'en_US.UTF-8 UTF-8' ####"
sleep 1
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
export LANG=en_US.UTF-8

#hostname
echo "#### Enter Hostname ####"
read hostname
echo "Hostname: $hostname"

echo "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\t$hostname.localdomain\t$hostname" >> /etc/hosts
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
echo "#### Uncomment '%wheel\tALL=(ALL)\tALL' ####"
sleep 5
EDITOR=nano visudo

#exit
echo "#### Base Install Success ####"
sleep 2
exit

#unmounting disk
umount -lR /mnt
reboot

