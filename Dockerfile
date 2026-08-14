# Official Node LTS image (buildpack-deps based): ships node, npm, and the
# full C++ toolchain (gcc/g++/make/python3). node-pty — a dsh dependency —
# publishes prebuilt binaries only for macOS/Windows, so on Linux it must
# compile from source via node-gyp; this image can do that out of the box.
FROM node:22-bookworm

# Working directory for the harness
WORKDIR /app

# Install dsh at build time so the image already contains it
# (node-pty compiles here via the image's C++ toolchain; no runtime
# npx download when the container starts)
RUN npm install -g @deepseek-ai/dsh

# Keep all harness user data under /app/.dsh
# (persist it with a Railway Volume mounted at /app/.dsh)
ENV DSH_HOME=/app/.dsh

# Wrapper that translates the PORT env var (default 8080) into
# dsh's --port flag; extra args are passed through to `dsh web`.
COPY --chmod=0755 entrypoint.sh /usr/local/bin/dsh-entrypoint

# Override at runtime: docker run -e PORT=9000 ...
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["dsh-entrypoint"]
