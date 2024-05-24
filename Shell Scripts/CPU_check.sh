#!/bin/bash

#check what type of CPU is on computer

string="here we are"
substring="here"

#check if substring is in string
if [[ $string == *$substring* ]] 
    then 
    echo "yes"
    else echo "no"
fi

<< com

Example 1:
string="Hello World!"
substring-"Hello"
returns True

Example 2:
string="Hello"
substring="Hello World!"
returns false

com

#check CPU on iMac 
CPU=$(sysctl -n machdep.cpu.brand_string)

if [[ $CPU == *"Intel"* ]]
    then
        echo "CPU is an Intel Chip"
    else
        echo "CPU is a Mac chip"
fi

