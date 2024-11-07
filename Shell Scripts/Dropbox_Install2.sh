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

    #Create Temp Folder (going to remove later)
    DATE=$(date '+%Y-%m-%d-%H-%M-%S')
    TempFolder="Download-$DATE"
    Location=/Users/Shared/$TempFolder
    mkdir $Location
    cd $Location

    # Download File into Temp Folder
    curl -s -o "$Location/DropboxInstaller.dmg" $URL

    # Capture name of Download File
    DownloadFile="$(ls)"

    echo "Downloaded $DownloadFile to $Location"

    # go to volumes folder and open dmg file
    cd /Volumes
    open $Location
    # install app
    cd $Location
    open 'Dropbox Installer'

    # install app
    cp -rf /Volumes/'Dropbox Installer'/'Dropbox Installer.app' /Applications

    hdiutil detach /Volumes/"Dropbox Installer"

    #remove temp folder
    rm -r $Location

    fi