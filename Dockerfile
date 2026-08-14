FROM btwiuse/arch:bun

# Working directory for the harness
WORKDIR /app

# node-pty (a dsh dependency) has no bundled linux-x64 prebuild, so it
# compiles from source via node-gyp, which needs a C++ toolchain.
RUN pacman -Syu --noconfirm base-devel

# Install dsh at build time so the image already contains it
# (no runtime `npx` download when the container starts)
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
