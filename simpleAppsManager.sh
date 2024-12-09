#!/bin/bash

UPDATES="$(pacman -Su --print-format %n%v)"

TotalUpdates="$(echo "$UPDATES" | wc -l)"

function showUpdate {
  echo "Available updates: $TotalUpdates"
  echo "$UPDATES" | less
}

function installPackage {
  clear
  read -r -p "Enter package name: " packageName
  pacman -S $packageName
}

function clearCache {
  clear
  pacman -Scc
}

PS3="Enter option: "
select option in "Show Updates" "Clear pacman's cache" "Install a package" "Exit program"; do
  case $option in
  "Exit program")
    break
    ;;
  "Show Updates")
    clear
    showUpdate
    ;;
  "Clear pacman's cache")
    clear
    clearCache
    ;;
  "Install a package")
    installPackage
    ;;
  *)
    clear
    echo "Sorry, wrong selection"
    ;;
  esac
done
clear
