#!/usr/bin/env bash

set -eu -o pipefail

# Variables
export DIR=$HOME/Downloads/temp/

function cleanDir() {
  #check for empty directory
  [[ -d $DIR ]] && rm -rf $DIR* || echo "$DIR does not exists!"
}

cleanDir

echo "Exit status: $?"
