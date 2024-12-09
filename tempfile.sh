#!/usr/bin/env bash

set -eu -o pipefail

# Variable
export DIR=$HOME/Downloads/temp/

function cleanDir() {
  #check for empty directory
  if [[ -d "$DIR" ]] then
	  if [[ "$(ls -A $DIR)" ]] then
		  rm -rf $DIR*
		  echo "Deleted $(ls -l | wc -l) contents successfully"
	  else
		  echo "$DIR is empty"
	  fi
   else
	   echo "$DIR does not exists!"
   fi
}

cleanDir

echo "Exit status: $?"
