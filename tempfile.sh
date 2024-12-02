#!/bin/bash

set -eu -o pipefail

# Variables
DIR=/home/ace64/Downloads/temp/

if [[ -e $DIR ]];
  then
    rm -rf $DIR*
else
  echo "$dir does not exist!"
fi

