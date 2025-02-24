#!/usr/bin/env bash

#Variables
URL
#branch to check
BRANCH='main'

git fetch $URL

CHANGES=$(git log origin..HEAD/$BRANCH --oneline)

if [ -z "$CHANGES" ]; then
    echo "No changes detected in branch $BRANCH."
else 
    echo "Building image"
    git pull $URL $BRANCH
