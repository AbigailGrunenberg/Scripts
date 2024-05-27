#!/bin/bash
#installation script for RStudio

Applications=(/Applications/*)
AppName="RStudio.app"

#check if R is already installed
if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "RStudio app already installed on device, terminiating installation."'
    exit 0
fi

#check what OS is run on computer
OS=$(sw_vers -productVersion)

if [[ $OS == *"12"* || $OS == *"13"* || $OS == *"14"* ]]
    then
        #continue with installation
        echo "Starting Installtion"
        URL="https://download1.rstudio.org/electron/macos/RStudio-2024.04.1-748.dmg"
        Location=/Users/Shared/RStudio-2024.04.1-748.dmg
        curl -Ls -o $Location $URL 

        hdiutil attach $Location

        # install app
        cp -rf /Volumes/$AppName /Applications

        open -a /Application/$AppName

        #unmount
        hdiutil detach $Location

    else
       osascript -e 'display alert "App Installation" message "Installation not compatible with current OS version, terminiating installation."'
       exit 0
fi