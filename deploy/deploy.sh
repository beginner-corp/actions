#!/bin/sh

set -e

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

# Set log
if [ "$LOG" = "verbose" ]; then
  cmd="$cmd -v"
elif [ "$LOG" = "debug" ]; then
  cmd="$cmd -d"
fi

# Allow arbitrary args
# TODO disallow &[&]?
if [ ! -z "${BEGIN_ARGS}" ]; then
  cmd="$cmd $BEGIN_ARGS"
fi

# Hit it
echo "final cmd: $cmd"
$cmd
