#!/bin/bash

#Dropbox Installation
#will need to test on better iMac 

#referenced from: https://apple.stackexchange.com/questions/73926/is-there-a-command-to-install-a-dmg

#check if Dropbox is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
AppName="Dropbox.app"
URL="https://www.dropbox.com/download?os=mac"
Location="/Users/Shared/DropboxInstaller.dmg"


if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Dropbox app already installed on device, terminiating installation."'
    exit 0
else   
    curl -Ls -o $Location $URL
    hdiutil attach $Location

    # install app
    cp -rf /Volumes/Dropbox.app /Applications

    open -a /Application/Dropbox.app

    #unmount
    hdiutil detach $Location
    
fi 
