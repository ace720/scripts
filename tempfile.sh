#!/bin/bash

set -eu -o pipefail

# Variables
export DIR=$HOME/Downloads/temp/

function cleanDir() {
#check for empty directory
  if [[ -d $DIR ]]; then
    rm -rf $DIR*
  else
    echo "$DIR does not exist!"
  fi
}

cleanDir

echo "Exit status: $?"
