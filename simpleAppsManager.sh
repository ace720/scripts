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

function removePackage {
  clear
  read -r -p "Enter package name to Uninstall: " packageName
  clear
  read -r -p "Do you want to uninstall with its dependency? [(Y)es or (N)o]: " varBool
  [[ "$varBool" == "Y" ]] && pacman -Rns $packageName || pacman -R $packageName
}

function retrieveInfo {
  clear
  read -r -p "Enter package name to retreive its information: " packageName
  pacman -Qi $packageName | sed '/Architecture/,+4d;/Required By/,+3d;/Install Reason/,+1d'
}

PS3="Enter option: "
select option in "Show Updates" "Query package information" "Clear pacman's cache" "Install a package" "Uninstall a package" "Exit program"; do
  case $option in
  "Exit program")
    break
    ;;
  "Query package information")
    clear
    retrieveInfo
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
  "Uninstall a package")
    removePackage
    ;;
  *)
    clear
    echo "Sorry, wrong selection"
    ;;
  esac
done
clear
