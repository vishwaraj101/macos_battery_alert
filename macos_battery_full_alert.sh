#!/bin/bash
#by @vishwaraj101

set_upper_limit=95
set_lower_limit=10

_is_charger_removed(){
count=1

power_mode=`pmset -g batt | head -n 1 | cut -c19- | rev | cut -c 2- | rev`
if [[ $power_mode == "AC Power" ]]
then
	say "Charger is plugged in now"
	say "Mac is charging now!"
	sleep 5m


elif [[ $power_mode == "Battery Power" ]]
	then
		say "Charger is unplugged! now"
		sleep 1h
fi
}

_battery_level_check(){

if [[ $1 -le $set_lower_limit ]]
then
	say "Battery is low please plug in the charger!"
	say "Battery is low please plug in the charger!"
	_is_charger_removed
fi

if [[ $1 -ge $set_upper_limit ]]
then
	say "Battery is $battery_level% charged please remove the charger"
	say "Battery is $battery_level% charged please remove the charger"
	_is_charger_removed
fi   
}

_check_battery_level()
{
battery_level=`pmset -g batt | awk '/-InternalBattery-0[[:space:]]/{print $3}' | awk '{print $1}' | tr -d '%;'`
_battery_level_check $battery_level
sleep 5m
}

check_is_screen_awake(){
#This line checks whether the user screen is awake or not if yes then it calls the batterycheck function
screen_check=`ioreg -n IODisplayWrangler | grep -i IOPowerManagement | perl -pe 's/^.DevicePowerState\"=([0-9]+).$/\1/'`
if [[ $screen_check == 4 ]]
then	
	_check_battery_level
fi
}

while true
do
	check_is_screen_awake
	sleep 30m
done
