#!/usr/bin/env bash

# Configuration
REPO_URL="git@1"
BRANCH="dev"
TRACKING_DIR='/home/ace360/Downloads/temp'
LIVE_BUILD_DIR='/home/ace360/Downloads/temp/'
LOG_FILE="$TRACKING_DIR/build.log"
LAST_COMMIT_FILE="$TRACKING_DIR/last_commit.txt"

# Ensure tracking directory exists
[[ -d $TRACKING_DIR ]] && cd $TRACKING_DIR || mkdir -p $TRACKING_DIR

# Clone or update the repository
if [[ -d "$LIVE_BUILD_DIR" ]]; then
  echo "Cloning repository..."
  git clone "$REPO_URL" "$LIVE_BUILD_DIR"
  cd "$LIVE_BUILD_DIR"
fi

#Get the latest commit hash from the remote branch
REMOTE_COMMIT=$(git rev-parse origin/$BRANCH)

#Get the last processed commit hash
if [[ -f "$LAST_COMMIT_FILE" ]]; then
  LAST_COMMIT=$(cat "$LAST_COMMIT_FILE")
else
  LAST_COMMIT=""
fi

# Check if there are new changes
if [[ "$REMOTE_COMMIT" != "$LAST_COMMIT" ]]; then
  echo "New changes detected. Starting build process..."
  echo "Build started at $(date)" >>"$LOG_FILE"

  #checkout the latest branch
  git checkout $BRANCH
  git pull origin $BRANCH

  #Start the live build process
  lb clean && lb config && lb build 2>&1 | tee -a "$LOG_FILE"

  #Check if the build was successful
  if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
    echo "Build successful."
    echo "Build successful at $(date)" >>"$LOG_FILE"
  else
    echo "Build failed."
    echo "Build failed at $(date)" >>"$LOG_FILE"
  fi

  #Update te last processed commit hash
  echo "$REMOTE_COMMIT" >"$LAST_COMMIT_FILE"
else
  echo "No new changes detected."
fi
