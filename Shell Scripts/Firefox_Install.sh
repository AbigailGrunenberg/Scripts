#!/bin/bash

#Dropbox Installation
#will need to test on better iMac 

#referenced from: https://apple.stackexchange.com/questions/73926/is-there-a-command-to-install-a-dmg and 
#https://github.com/TheJumpCloud/support/blob/master/PowerShell/JumpCloud%20Commands%20Gallery/Mac%20Commands/Application%20Installs/Mac%20-%20Install%20Chrome%20DMG.md

#check if Dropbox is already installed
#list of applications currently on Mac
Applications=(/Applications/*)
AppName="Firefox.app"

URL="https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US"

if [[ ${Applications[@]} =~ "/Applications/$AppName" ]]
    then
    osascript -e 'display alert "App Installation" message "Dropbox app already installed on device, terminiating installation."'
    exit 0
else   
    #continue with installation
    echo "Starting Installation"

    regex='^https.*.dmg$'
    if [[ $URL =~ $regex ]]; then
        echo "URL points to direct DMG download"
        validLink="True"
    else
        echo "Searching headers for download links"
        urlHead=$(curl -s --head $URL)

        locationSearch=$(echo "$urlHead" | grep https:)

        if [ -n "$locationSearch" ]; then

            locationRaw=$(echo "$locationSearch" | cut -d' ' -f2)

            locationFormatted="$(echo "${locationRaw}" | tr -d '[:space:]')"

            regex='^https.*'
            if [[ $locationFormatted =~ $regex ]]; then
                echo "Download link found"
                URL=$(echo "$locationFormatted")
            else
                echo "No https location download link found in headers"
                exit 1
            fi

        else

            echo "No location download link found in headers"
            exit 1
        fi

    fi

    #Create Temp Folder
    DATE=$(date '+%Y-%m-%d-%H-%M-%S')
    TempFolder="Download-$DATE"
    Location="/tmp/$TempFolder"
    mkdir /tmp/$TempFolder
    cd $Location


    # Download File into Temp Folder
    curl -s -O "$URL"

    # Capture name of Download File
    DownloadFile="$(ls)"

    echo "Downloaded $DownloadFile to $Location"

    # Verifies DMG File
    regex='\.dmg$'
    if [[ $DownloadFile =~ $regex ]]; then
        DMGFile="$(echo "$DownloadFile")"
        echo "DMG File Found: $DMGFile"
    else
        echo "File: $DownloadFile is not a DMG"
        rm -r $Location
        echo "Deleted $Location"
        exit 1
    fi

    # Mount DMG File -nobrowse prevents the volume from popping up in Finder
    hdiutilAttach=$(hdiutil attach $Location/$DMGFile -nobrowse)
    echo "Used hdiutil to mount $DMGFile "

    regex='\/Volumes\/.*'
    if [[ $hdiutilAttach =~ $regex ]]; then
        DMGVolume="${BASH_REMATCH[@]}"
        echo "Located DMG Volume: $DMGVolume"
    else
        echo "DMG Volume not found"
        rm -r $Location
        echo "Deleted $Location"
        exit 1
    fi

    # Identify the mount point for the DMG file
    DMGMountPoint="$(hdiutil info | grep "$DMGVolume" | awk '{ print $1 }')"
    echo "Located DMG Mount Point: $DMGMountPoint"

    # Capture name of App file
    cd "$DMGVolume"
    AppName="$(ls | Grep .app)"
    cd ~
    echo "Located App: $AppName"

    DMGAppPath=$(find "$DMGVolume" -name "*.app" -depth 1)

    # Copy the contents of the DMG file to /Applications/
    # Preserves all file attributes and ACLs
    cp -pPR "$DMGAppPath" /Applications/

    err=$?
    if [ ${err} -ne 0 ]; then
        echo "Could not copy $DMGAppPath Error: ${err}"
        hdiutil detach $DMGMountPoint
        echo "Used hdiutil to detach $DMGFile from $DMGMountPoint"
        rm -r $Location
        echo "Deleted $Location"
        exit 1
    fi

    echo "Copied $DMGAppPath to /Applications"

    # Unmount the DMG file
    hdiutil detach $DMGMountPoint
    echo "Used hdiutil to detach $DMGFile from $DMGMountPoint"

    err=$?
    if [ ${err} -ne 0 ]; then
        abort "Could not detach DMG: $DMGMountPoint Error: ${err}"
    fi

    # Remove Temp Folder and download
    rm -r $Location
    echo "Deleted $Location"
       
fi 
