#!/bin/bash

#test shell script for Mac
#want to create a shell script to automatically download Spotify

# Download URL for Spotify
Spotify_URL="https://spotify.link/lz04YJ0r9ib?label=sp_cid%3Ae021310b-14ab-4b5c-8161-da7fba2019d0"

syslog -s -l error "Spotify - Starting Download/Install sequence."

wget $Spotify_URL

sudo installer -pkg /path/to/package.pkg -target /


# Grant execution permissions to the script
chmod +x script.sh

#get pkg 
curl --output /Users/AG/Downloads/Spotify.pkg "https://spotify.link/lz04YJ0r9ib?label=sp_cid%3Ae021310b-14ab-4b5c-8161-da7fba2019d0"
printf "Spotify Downloaded\n"
printf "Spotify Installing\n"

installer -pkg /Users/AG/Downloads/Spotify.pkg -target /
printf "Spotify Installed\n"

cd /Users/AG/Downloads; rm Spotify.pkg
printf "Install package removed\n" 