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

#parts of installation code from: 
# https://github.com/TheJumpCloud/support/blob/master/PowerShell/JumpCloud%20Commands%20Gallery/Mac%20Commands/Application%20Installs/Mac%20-%20Install%20Chrome%20DMG.md

if [[ $OS == *"12"* || $OS == *"13"* || $OS == *"14"* ]]
    then
        #continue with installation
        echo "Starting Installation"
        URL="https://download1.rstudio.org/electron/macos/RStudio-2024.04.1-748.dmg"
        Location=/Users/Shared/RStudio-2024.04.1-748.dmg


        #Create Temp Folder
        DATE=$(date '+%Y-%m-%d-%H-%M-%S')
        TempFolder="Download-$DATE"
        mkdir /tmp/$TempFolder
        cd /tmp/$TempFolder

        # Download File into Temp Folder
        curl -s -O "$URL"

        # Capture name of Download File
        DownloadFile="$(ls)"

        echo "Downloaded $DownloadFile to /tmp/$TempFolder"

        # Verifies DMG File
        regex='\.dmg$'
        if [[ $DownloadFile =~ $regex ]]; then
            DMGFile="$(echo "$DownloadFile")"
            echo "DMG File Found: $DMGFile"
        else
            echo "File: $DownloadFile is not a DMG"
            rm -r /tmp/$TempFolder
            echo "Deleted /tmp/$TempFolder"
            exit 1
        fi

        # Mount DMG File -nobrowse prevents the volume from popping up in Finder
        hdiutilAttach=$(hdiutil attach /tmp/$TempFolder/$DMGFile -nobrowse)
        echo "Used hdiutil to mount $DMGFile "

        regex='\/Volumes\/.*'
        if [[ $hdiutilAttach =~ $regex ]]; then
            DMGVolume="${BASH_REMATCH[@]}"
            echo "Located DMG Volume: $DMGVolume"
        else
            echo "DMG Volume not found"
            rm -r /tmp/$TempFolder
            echo "Deleted /tmp/$TempFolder"
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
            rm -r /tmp/$TempFolder
            echo "Deleted /tmp/$TempFolder"
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
        rm -r /tmp/$TempFolder
        echo "Deleted /tmp/$TempFolder"

    else
       osascript -e 'display alert "App Installation" message "Installation not compatible with current OS version, terminiating installation."'
       exit 0
fi
