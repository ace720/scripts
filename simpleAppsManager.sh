#!/usr/bin/env bash

set -eu -o pipefail

echo "Simple package manager for Arch-linux"
echo "Updating databases..."

#Global variables
UPDATES="$(pacman -Su --print-format %n%v)"

packageStoreDir=/var/cache/pacman/pkg/

function appSummary {
  echo "================================================="
  echo "SYSTEM & PACKAGES SUMMARY"
  echo "================================================="
  echo -e "System Architecture: \033[1m$(showArchitecture)\033[0m"
  echo -e "Total Packages Installed: \033[1m$(totalPackages) packages\033[0m"
  echo -e "Total Updates: \033[1m$TotalUpdates packages\033[0m"
  echo -e "Total installed packages size: \033[1m$(totalInstalledSize)\033[0m"
  echo -e "Total cached size: \033[1m$(packageCacheSize)\033[0m"
  echo "================================================="
  echo " "
}

function totalUpdates {
  pacman -Su --print-format %r/ | awk '{if($1=="core/"){total+=1} else if($1=="extra/"){total+=1}}END{print total}'
}
TotalUpdates="$(totalUpdates)"

function viewLog {
  cat /var/log/pacman.log | awk '{
  if ($3 != "running" && $3 != "Running" && $3 != "synchronizing" && $3 != "starting" && $2 != "[ALPM-SCRIPTLET]" && $3 != "transaction")
  {print $0}
  }'
}

function showUpdate {
  echo "Available updates: $TotalUpdates"
  echo "$UPDATES" | less
}

function update {
  pacman -Syu
}

function showArchitecture {
  uname -a | awk '{arch=$13; print arch}'
}

function totalPackages {
  pacman -Q | wc -l
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

function packageCacheSize {
  du -hc $packageStoreDir | awk '{if($2=="total"){print $1}}'
}

function packageSize {
  clear
  read -r -p "Enter package name to determine its size (or press ENTER to show all installed packages size): " packageName
  LC_ALL=C.UTF-8 pacman -Qi $packageName | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | LC_ALL=C.UTF-8 sort -h
}

function totalInstalledSize {
  pacman -Qi | awk '/^Installed Size/{size=$4; unit=$5; if(unit=="KiB"){total+=size/1024/1024} else if(unit=="MiB"){total+=size/1024} else if(unit=="GiB"){total+=size}}END{printf "%.2fGB\n", total}'
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

function manageCache {
  PS3="Choose one option: "
  select option in "Clear pacman's cache" "Show pacman cache size" "Return to previous menu" "Exit program"; do
    case $option in
    "Exit program")
      exit 0
      ;;
    "Show pacman cache size")
      clear
      packageCacheSize
      ;;
    "Clear pacman's cache")
      clearCache
      ;;
    "Return to previous menu")
      clear
      main
      ;;
    *)
      clear
      echo "Sorry!, Wrong selection"
      ;;
    esac
  done
}

function installNmanage {
  PS3="Select one option: "
  select option in "Show Updates" "Update packages" "Install a package" "Uninstall a package" "Return to previous menu" "Exit program"; do
    case $option in
    "Exit program")
      clear
      exit 0
      ;;
    "Show Updates")
      clear
      showUpdate
      ;;
    "Update packages")
      clear
      update
      ;;
    "Install a package")
      clear
      installPackage
      ;;
    "Uninstall a package")
      clear
      removePackage
      ;;
    "Return to previous menu")
      clear
      main
      ;;
    "Exit program")
      clear
      exit 0
      ;;
    *)
      clear
      echo "Sorry!, Wrong selection"
      ;;
    esac
  done
}

function main {
  clear
  appSummary
  PS3="Enter option: "
  select option in "Install & Manage" "Show package installed size" "Query package information" "Manage pacman cache" "View log" "Exit program"; do
    case $option in
    "Exit program")
      clear
      exit 0
      ;;
    "Query package information")
      clear
      retrieveInfo
      ;;
    "Show package installed size")
      clear
      packageSize
      ;;
    "Install & Manage")
      clear
      installNmanage
      ;;
    "Manage pacman cache")
      clear
      manageCache
      ;;
    "View log")
      clear
      viewLog
      ;;
    *)
      clear
      echo "Sorry, wrong selection"
      ;;
    esac
  done
  clear
}

main
