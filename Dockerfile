FROM btwiuse/arch:bun

# Install dsh at build time so the image already contains it
# (no runtime `npx` download when the container starts)
RUN bun add -g @deepseek-ai/dsh

# bun's global bin dir (installs as root in the image)
ENV PATH="/root/.bun/bin:${PATH}"

# Port used by `dsh web`
EXPOSE 3080

# Run the DeepSeek Harness web UI (already installed at build time)
CMD dsh web
