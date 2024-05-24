#!/bin/bash

#installation script to install Spotify 

#check if Spotify is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
DownloadLocation="/Users/Shared/"
SpotifyLocation="/Applications/Spotify.app"
AppName="Spotify.app"
URL="https://download.scdn.co/SpotifyInstaller.zip"

#download from URL
if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Spotify app already installed on device, terminiating installation."'
    exit 0
else   
    curl -Ls -o /Users/Shared/SpotifyInstaller.zip $URL
    
    #unzip SpotifyInstaller.zip
    unzip "$DownloadLocation/SpotifyInstaller.zip"

    #run Install Spotify.app
    open -a Install\ Spotify.app 

    #remove SpotifyInstaller.zip
    cd /Users/Shared; rm -v SpotifyInstaller.zip
    cd /Users/Shared; rm -v Install\ Spotify.app
fi 