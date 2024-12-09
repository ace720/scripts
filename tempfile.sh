#!/usr/bin/env bash

set -eu -o pipefail

# Variable
export DIR=$HOME/Downloads/temp/

function cleanDir() {
  #check for empty directory
  [[ -d $DIR ]] && rm -rf $DIR* || echo "$DIR does not exists!"
}

cleanDir

echo "Exit status: $?"
