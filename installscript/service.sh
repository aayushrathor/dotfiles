## cron jobs
# # notify if battery is less than 15%
# */1 * * * * DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 batteryWarning
#
# # pacman updates
# 0 */3 * * * DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 update_pacman
#
# # aur updates
# 0 */3 * * * DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus DISPLAY=:0 aur_update

## symlinks
sudo ln -sf ~/scripts/0x0 /usr/local/bin/0x0
sudo ln -sf ~/scripts/aur_update /usr/local/bin/aur_update
sudo ln -sf ~/scripts/batteryWarning /usr/local/bin/batteryWarning
sudo ln -sf ~/scripts/bt-device /usr/local/bin/bt-device
sudo ln -sf ~/scripts/copy /usr/local/bin/copy
sudo ln -sf ~/scripts/dunst-notif.sh /usr/local/bin/dunst-notif.sh
sudo ln -sf ~/scripts/fshare /usr/local/bin/fshare
sudo ln -sf ~/scripts/ftemp /usr/local/bin/ftemp
sudo ln -sf ~/scripts/fzfbluetooth /usr/local/bin/fzfbluetooth
sudo ln -sf ~/scripts/fzfpower /usr/local/bin/fzfpower
sudo ln -sf ~/scripts/i /usr/local/bin/i
sudo ln -sf ~/scripts/imgsearch /usr/local/bin/imgsearch
sudo ln -sf ~/scripts/ipinfo /usr/local/bin/ipinfo
sudo ln -sf ~/scripts/lockscreen /usr/local/bin/lockscreen
sudo ln -sf ~/scripts/music /usr/local/bin/music
sudo ln -sf ~/scripts/mysql_setup /usr/local/bin/mysql_setup
sudo ln -sf ~/scripts/ocr /usr/local/bin/ocr
sudo ln -sf ~/scripts/open /usr/local/bin/open
sudo ln -sf ~/scripts/pacman.sh /usr/local/bin/pacman.sh
sudo ln -sf ~/scripts/pipenv /usr/local/bin/pipenv
sudo ln -sf ~/scripts/popup_cal /usr/local/bin/popup_cal
sudo ln -sf ~/scripts/rofi_keybinds.sh /usr/local/bin/rofi_keybinds.sh
sudo ln -sf ~/scripts/screenRecord /usr/local/bin/screenRecord
sudo ln -sf ~/scripts/seekBack /usr/local/bin/seekBack
sudo ln -sf ~/scripts/seekFor /usr/local/bin/seekFor
sudo ln -sf ~/scripts/sleep /usr/local/bin/sleep
sudo ln -sf ~/scripts/toggleBT /usr/local/bin/toggleBT
sudo ln -sf ~/scripts/toggle_polybar /usr/local/bin/toggle_polybar
sudo ln -sf ~/scripts/update_pacman /usr/local/bin/update_pacman
sudo ln -sf ~/scripts/volume /usr/local/bin/volume
sudo ln -sf ~/scripts/yt-mp3 /usr/local/bin/yt-mp3
