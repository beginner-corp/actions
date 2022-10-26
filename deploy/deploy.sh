#!/bin/sh

set -e

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

echo "begin path? $HOME/.begin"
echo "github path: $GITHUB_PATH"
echo "$HOME/.begin" >> $GITHUB_PATH

# Hit it
$cmd
