#!/bin/bash
 
# Variables
dir=/home/ace64/Downloads/temp/

if [[ -e $dir ]];
  then
    rm -rf $dir*
else
  echo "$dir does not exist!"
fi

