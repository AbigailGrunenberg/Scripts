#!/bin/bash

#check if Cisco Secure Endpoint is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
CiscoLocation="/Applications/Cisco/'Cisco AnyConnect Secure Mobility Client.app'"
AppName="Cisco"

if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Cisco app already installed on device, terminiating installation."'
    exit 0
else   
    curl -Ls -o /Users/Shared/DropboxInstaller.dmg $URL
    hdiutil attach /Users/Shared/DropboxInstaller.dmg

    # install app
    cp -rf /Volumes/Dropbox.app /Applications

    open -a /Application/Dropbox.app

    #unmount
    hdiutil detach /Users/Shared/DropboxInstaller.dmg
    
fi 
