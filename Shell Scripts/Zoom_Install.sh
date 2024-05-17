#!/bin/bash

#check if zoom.us.app is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
ZoomLocation="/Applications/zoom.us.app"
AppName="Zoom"

if [[ ${Applications[@]} =~ $AppName ]]
    then
    echo "Array element exists"
    exit 0
else   
    echo "Starting installation of $"
    curl -Ls -o /Users/Shared/zoom.pkg 'https://zoom.us/client/6.0.2.33403/zoomusInstallerFull.pkg'
    installer -pkg /Users/Shared/zoom.pkg -target /
    cd /Users/Shared; rm -v zoom.pkg
fi 