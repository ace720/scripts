#! /usr/bin/env bash

upddates=$(pacman -Su --print-format %n-%v)
packages=$(ls ./)

for update in $upddates; do
  for package in $packages; do
    if [[ $package != *.sig ]]; then
      if [[ $package == $update* ]]; then
        pacman -U ./$package
      fi
    fi
  done
done
