FROM btwiuse/arch:bun

# Working directory for the harness
WORKDIR /app

# Install dsh at build time so the image already contains it
# (no runtime `npx` download when the container starts)
RUN bun add -g @deepseek-ai/dsh

# bun's global bin dir (installs as root in the image)
ENV PATH="/root/.bun/bin:${PATH}"

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
