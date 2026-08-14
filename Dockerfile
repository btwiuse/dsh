FROM btwiuse/arch:bun

# Port used by `dsh web`
EXPOSE 3080

# Download and run the DeepSeek Harness web UI
CMD npx -y @deepseek-ai/dsh web
