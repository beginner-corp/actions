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
if [ "$INPUT_LOG" = "verbose" ]; then cmd+=" -v"
elif [ "$INPUT_LOG" = "debug" ]; then cmd+=" -d"
fi

# Allow arbitrary args
# TODO disallow &[&]?
if [[ ! -z "${INPUT_BEGIN_ARGS}" ]]; then cmd+=" $INPUT_BEGIN_ARGS"
fi

# Hit it
$cmd
