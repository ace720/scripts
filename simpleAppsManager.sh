#!/bin/bash

UPDATES="$(pacman -Su --print-format %n%v)"

TotalUpdates="$(echo "$UPDATES" | wc -l)"

function showUpdate {
  echo "Available updates: $TotalUpdates"
  echo "$UPDATES" | less
}

function ignorePackage {
  clear

}

function memUsage {
  clear
  cat /proc/meminfo
}

PS3="Enter option: "
select option in "Show Updates" "Display logged on users" "Display memory usage" "Exit program"; do
  case $option in
  "Exit program")
    break
    ;;
  "Show Updates")
    clear
    showUpdate
    ;;
  "Display logged on users")
    whoseon
    ;;
  "Display memory usage")
    memUsage
    ;;
  *)
    clear
    echo "Sorry, wrong selection"
    ;;
  esac
done
clear
