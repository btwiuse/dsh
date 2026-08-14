FROM btwiuse/arch:bun

RUN pacman -Syu --noconfirm base-devel

COPY --chmod=0755 entrypoint.sh /usr/local/bin/dsh-entrypoint

# Override at runtime: docker run -e PORT=9000 ...
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["dsh-entrypoint"]
