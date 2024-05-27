#!/bin/bash
#check what OS is run on computer

OS=$(sw_vers -productVersion)
Version=0 #what version you're looking for

if [[ $OS == *$Version* ]]
    then
        echo "$Version"
    else
        echo "Not what you are looking for"
fi

