#!/bin/bash

set -eu -o pipefail

# Variables
DIR=/home/ace64/Downloads/temp/

function cleanDir() {
  if [[ -e $DIR ]]; then
    rm -rf $DIR*
  else
    echo "$DIR does not exist!"
  fi
}

cleanDir
