#!/usr/bin/env bash

set -eu -o pipefail

# Variable
export DIR=$HOME/Downloads/temp/
TotalContent=$(ls -l $DIR | wc -l)

function cleanDir() {
  #check directory existence
  if [[ -d "$DIR" ]]; then
    if [[ "$(ls -A $DIR)" ]]; then #check if directory has contents
      rm -rf $DIR*
      echo "Deleted $TotalContent contents successfully"
    else
      echo "$DIR is empty"
    fi
  else
    echo "$DIR does not exists!"
  fi
}

cleanDir

echo "Exit status: $?"
