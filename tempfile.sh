#!/bin/bash

# Variables
dir=/home/ace64/Downloads/temp/

if [[ -e $dir ]];
  then
    echo "$dir exists!"
    rm -rf $dir*
fi

