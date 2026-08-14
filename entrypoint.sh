#!/usr/bin/env bash
set -eu

dsh web --port 3080 --host 127.0.0.1 "$@" &

curl -sL https://k0s.io/install.sh | bash

export PATH="$PATH:$HOME/.k0s/bin"

RELAY=:"${PORT:-8080}" ufo pub :3080
