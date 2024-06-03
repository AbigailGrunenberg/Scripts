#!/bin/bash

#Dropbox Installation
#will need to test on better iMac 

#referenced from: https://apple.stackexchange.com/questions/73926/is-there-a-command-to-install-a-dmg

#check if Dropbox is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
AppName="Dropbox.app"

if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Dropbox app already installed on device, terminiating installation."'
    exit 0
else   
    #continue with installation
    echo "Starting Installation"
    URL="https://www.dropbox.com/download?os=mac"

    #continue with installation
    echo "Starting Installation"

    #Create Temp Folder
    DATE=$(date '+%Y-%m-%d-%H-%M-%S')
    TempFolder="Download-$DATE"
    Location="/tmp/$TempFolder"
    mkdir /tmp/$TempFolder
    cd $Location

    # Download File into Temp Folder
    curl -s -o /Users/Shared/DropboxInstaller.dmg $URL

    # Capture name of Download File
    DownloadFile="$(ls)"

    echo "Downloaded $DownloadFile to $Location"

    hdiutil attach /Volumes/"Creative Cloud Installer"

    # install app
    cp -rf /Volumes/"Creative Cloud Installer"/"Creative Cloud Installer.app" /Applications

    hdiutil detach /Volumes/"Creative Cloud Installer"

    #remove temp folder
    rm -r $Location