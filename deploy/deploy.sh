#!/bin/sh

set -e

# Check for Begin app ID
ARCFILE=".arc"
if [ -e app.arc ]
then
  ARCFILE="app.arc"
fi

if [ -z "${BEGIN_TOKEN}" ]; then
  echo "Error: Missing begin_token"
  exit 1
fi

if grep -q "@begin" "$ARCFILE"  &&  grep -q "appID" "$ARCFILE"
then
  echo "Discovered Begin app ID in $ARCFILE"
else
  echo "Please create your app via `begin create` before attempting to deploy"
  exit 1
fi

# Make sure Begin is installed
if ! command -v npx begin > /dev/null; then
  echo "Error: Begin not found" 1>&2
  exit 1
fi

# Install deps if necessary
if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
  npm i --omit=dev
fi

# Base command
cmd="npx begin deploy"

if [ ! -z "${LOG}" ]; then
  cmd="$cmd --$LOG"
fi

# Deploy a specific named environment
if [ ! -z "${BEGIN_ENV_NAME}" ]; then
  cmd="$cmd -e $BEGIN_ENV_NAME"
fi

# Allow arbitrary args
# TODO disallow &[&]?
if [ ! -z "${BEGIN_ARGS}" ]; then
  cmd="$cmd $BEGIN_ARGS"
fi

# Hit it
if $cmd; then
  echo "Deployed successfully"
else
  echo "Deploy failed"
  exit 1
fi
