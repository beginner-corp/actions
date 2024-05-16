#!/bin/sh

set -e

# create ~/.begin dir
mkdir -p ~/.begin
# create ~/.begin/config with telemetry disabled
echo '{"collectBasicTelemetry":false}' > ~/.begin/config.json
