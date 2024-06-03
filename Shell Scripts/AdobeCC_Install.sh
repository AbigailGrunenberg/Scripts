#!/bin/bash

#installation script for Adobe Creative Cloud (.dmg)
URL="https://creativecloud.adobe.com/apps/download/creative-cloud#"

#!/bin/bash

#referenced from: https://apple.stackexchange.com/questions/73926/is-there-a-command-to-install-a-dmg and 
#https://github.com/TheJumpCloud/support/blob/master/PowerShell/JumpCloud%20Commands%20Gallery/Mac%20Commands/Application%20Installs/Mac%20-%20Install%20Chrome%20DMG.md

#check if Creative Cloud is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
AppName="Adobe Creative Cloud"

URL="https://creativecloud.adobe.com/apps/download/creative-cloud#"

if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Adobe Creative Cloud app already installed on device, terminiating installation."'
    exit 0
else   
    #continue with installation
    echo "Starting Installation"

    #Create Temp Folder
    DATE=$(date '+%Y-%m-%d-%H-%M-%S')
    TempFolder="Download-$DATE"
    Location="/tmp/$TempFolder"
    mkdir /tmp/$TempFolder
    cd $Location

    # Download File into Temp Folder
    curl -s -O $URL

    # Capture name of Download File
    DownloadFile="$(ls)"

    echo "Downloaded $DownloadFile to $Location"

    hdiutil attach /Volumes/"Creative Cloud Installer"

    # install app
    cp -rf /Volumes/"Creative Cloud Installer"/"Creative Cloud Installer.app" /Applications

    hdiutil detach /Volumes/"Creative Cloud Installer"

    #remove temp folder
    rm -r $Location