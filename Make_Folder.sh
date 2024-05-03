#!/bin/bash
#simple script to create a folder on the desktop of given user

# Get the currently logged in username. 
currentUser=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ {print $3}') 

#make folder in desktop of logged in user
mkdir -p /Users/currentUser/Desktop/Test_Folder

#make the commands executable in terminal
chmod +x Make_Folder
./Make_Folder
