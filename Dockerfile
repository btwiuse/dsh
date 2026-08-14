FROM btwiuse/arch:bun

# Install dsh at build time so the image already contains it
# (no runtime `npx` download when the container starts)
RUN bun add -g @deepseek-ai/dsh

# bun's global bin dir (installs as root in the image)
ENV PATH="/root/.bun/bin:${PATH}"

# `dsh web` reads its port only from the --port flag (default 3080), so
# translate the conventional PORT env var into that flag at startup.
# Override at runtime with: docker run -e PORT=9000 ...
ENV PORT=8080
EXPOSE 8080

CMD sh -c 'exec dsh web --port "${PORT:-8080}"'
