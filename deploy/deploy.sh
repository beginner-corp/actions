#!/bin/sh

set -e

# Check for Begin app ID
if  grep -q "@begin" ".arc"  &&  grep -q "appID" ".arc"
then
  echo "Begin app exists"
else
  echo "Please create your app via `begin create` before attempting to deploy"
  exit 0
fi

# Make sure Begin is installed
if ! command -v begin > /dev/null; then
  echo "Error: Begin not found" 1>&2
  exit 1
fi

# Install deps if necessary
if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
  npm i --production
fi

# Base command
cmd="begin deploy"

# Set log level
if [ "$LOG" = "verbose" ]; then
  cmd="$cmd -v"
elif [ "$LOG" = "debug" ]; then
  cmd="$cmd -d"
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
$cmd
