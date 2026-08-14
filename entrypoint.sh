#!/usr/bin/env sh
set -eu

# The dsh CLI reads its listen port only from the --port flag
# (composed default 3080), so translate the conventional PORT
# env var (default 8080) into that flag.
#
# Override at runtime: docker run -e PORT=9000 ...
exec npx -y @deepseek-ai/dsh web --port "${PORT:-8080}" "$@"
