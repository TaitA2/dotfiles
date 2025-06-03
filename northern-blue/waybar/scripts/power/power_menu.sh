#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
## style-6   style-7   style-8   style-9   style-10

# Current Theme
theme='/home/adam/.config/waybar/scripts/power/style.rasi'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown=''
reboot=''
lock=''
suspend=''
logout=''
yes=''
no=' '

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-theme $theme
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme $theme
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$shutdown\n$reboot\n$lock" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
    shutdown now
        ;;
    $reboot)
    reboot
        ;;
    $lock)
		hyprlock 
        ;;
esac
