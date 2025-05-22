# Usa Alpine come base per compatibilità con Home Assistant
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Imposta la lingua
ENV LANG C.UTF-8

# Installa i pacchetti necessari
RUN apk add --no-cache \
    bash \
    curl \
    tar \
    libpcap \
    iproute2 \
    libc6-compat \
    python3

# Crea la cartella di destinazione
RUN mkdir -p /opt/xlinkkai

# Copia l’archivio precedentemente scaricato nella build
COPY xlinkkai.tar.gz /tmp/xlinkkai.tar.gz

# Estrai e dai i permessi di esecuzione
RUN tar -xzf /tmp/xlinkkai.tar.gz -C /opt/xlinkkai && \
    chmod +x /opt/xlinkkai/kaiEngine

# (Facoltativo) Copia script o web UI se necessario
COPY run.sh /run.sh
COPY web /web
RUN chmod +x /run.sh

# Espone la porta usata da XLink Kai (8099 di default)
EXPOSE 8099

# Comando di avvio
CMD ["/run.sh"]
