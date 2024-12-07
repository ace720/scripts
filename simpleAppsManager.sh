#!/bin/bash

pacman -Su >UPDATES

function showUpdate {
  echo "Available updates: $UPDATES"
}

function whoseon {
  clear
  who
}

function memUsage {
  clear
  cat /proc/meminfo
}

PS3="Enter option: "
select option in "Display disk space" "Display logged on users" "Display memory usage" "Exit program"; do
  case $option in
  "Exit program")
    break
    ;;
  "Display disk space")
    checkUpdate
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
