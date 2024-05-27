#!/bin/bash

#R intallation for Intel and Mac chips

Applications=(/Applications/*)
AppName="R.app"

#check if R is already installed
if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "R app already installed on device, terminiating installation."'
    exit 0
fi

#check what type of chip computer has:
#check CPU on iMac 
CPU=$(sysctl -n machdep.cpu.brand_string)

if [[ $CPU == *"Intel"* ]]
    then
        #Intel chip installation
        echo "CPU is an Intel Chip"
        URL="https://cran.r-project.org/bin/macosx/big-sur-x86_64/base/R-4.4.0-x86_64.pkg"
        Location=/Users/Shared/R-4.4.0-x86\ 64.pkg
        curl -Ls -o $Location $URL 
        installer -pkg $Location -target /Applications

        rm $Location
    else
        #Mac chip installation
        echo "CPU is a Mac chip"
        URL="https://cran.r-project.org/bin/macosx/big-sur-arm64/base/R-4.4.0-arm64.pkg"
        Location=/Users/Shared/R-4.4.0-arm64.pkg
        curl -Ls -o $Location $URL
        installer -pkg $Location -target /Applications

        rm $Location
fi

