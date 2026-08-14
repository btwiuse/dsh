FROM btwiuse/arch:bun

# Working directory for the harness
WORKDIR /app

# node-pty (a dsh dependency) ships prebuilt binaries only for macOS/Windows,
# so on Linux it compiles from source via node-gyp, which needs a C++ toolchain
# (g++/make). Without this, `npx @deepseek-ai/dsh` fails with
# "make: g++: No such file or directory".
RUN pacman -Syu --noconfirm base-devel

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
