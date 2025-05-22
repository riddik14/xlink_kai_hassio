ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Installa dipendenze
RUN apk add --no-cache bash curl tar

# Scarica e installa XLink Kai
RUN mkdir -p /opt/xlinkkai && \
    curl -L -o /tmp/xlinkkai.tar.gz https://dist.teamxlink.co.uk/linux/debian/static/standalone/release/amd64/xlinkkai_7.4.45_651430714_standalone_x86_64.tar.gz && \
    tar -xzf /tmp/xlinkkai.tar.gz -C /opt/xlinkkai --strip-components=1 && \
    chmod +x /opt/xlinkkai/kaiEngine

# Copia il file di avvio
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Esegui run.sh come PID 1
CMD [ "/run.sh" ]
