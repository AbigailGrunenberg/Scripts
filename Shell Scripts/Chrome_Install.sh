#!/bin/bash

#script to install Chrome

#check if Chrome is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
ChromeLocation="/Applications/Google Chrome.app"
AppName="Google Chrome.app"

if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Google Chrome app already installed on device, terminiating installation."'
    exit 0
else   
    curl -Ls -o /Users/Shared/Chrome.pkg 'https://dl.google.com/chrome/mac/stable/gcem/GoogleChrome.pkg'
    installer -pkg /Users/Shared/Chrome.pkg -target /Applications
    cd /Users/Shared; rm -v Chrome.pkg
fi 