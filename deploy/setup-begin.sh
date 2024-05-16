#!/bin/sh

set -e

# ! GH Actions won't allow this:
sudo mkdir -p ~/.begin
sudo touch ~/.begin/config.json
sudo echo '{"collectBasicTelemetry":false}' > ~/.begin/config.json
