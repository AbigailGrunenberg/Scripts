#!/bin/bash

#check if zoom.us.app is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
ZoomLocation="/Applications/zoom.us.app"
AppName="zoom.us.app"
Location=/Users/Shared/zoom.pkg

if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Zoom app already installed on device, terminiating installation."'
    exit 0
else   
    curl -Ls -o $Location 'https://zoom.us/client/6.0.2.33403/zoomusInstallerFull.pkg'
    installer -pkg $Location -target /
    cd /Users/Shared; rm -v zoom.pkg
fi 

