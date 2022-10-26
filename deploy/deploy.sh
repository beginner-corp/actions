#!/bin/sh

set -e

echo "begin path? $HOME/.begin"
echo "github path before: $GITHUB_PATH"
echo "path before: $PATH"
echo "$HOME/.begin" >> $GITHUB_PATH
echo "github path after: $GITHUB_PATH"
echo "path after: $PATH"

# Make sure Begin is installed
if ! command -v begin > /dev/null; then
  echo "Error: Begin not found" 1>&2
  exit 1
fi

# Base command
cmd="begin deploy"

# Set log
if [ "$LOG" = "verbose" ]; then cmd+=" -v"
elif [ "$LOG" = "debug" ]; then cmd+=" -d"
fi

# Allow arbitrary args
# TODO disallow &[&]?
if [[ ! -z "${BEGIN_ARGS}" ]]; then cmd+=" $BEGIN_ARGS"
fi

# Hit it
$cmd