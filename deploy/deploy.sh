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

test="hi"
test+=" there"
echo "test: $test"

echo "cmd: $cmd"
echo "log: $LOG"
echo "args: $BEGIN_ARGS"

# Set log
if [ "$LOG" = "verbose" ]; then
  echo "got verbose!"
  cmd+=" -v"
elif [ "$LOG" = "debug" ]; then
  echo "got debug!"
  cmd+=" -d"
fi

# # Allow arbitrary args
# # TODO disallow &[&]?
# if [[ ! -z "${BEGIN_ARGS}" ]];
#   then cmd+=" $BEGIN_ARGS"
# fi

# Hit it
echo "final cmd: $cmd"
$cmd
