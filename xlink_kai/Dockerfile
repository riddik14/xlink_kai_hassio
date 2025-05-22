ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

RUN apk add --no-cache \
    libpcap \
    bash \
    curl \
    unzip \
    libc6-compat \
    iproute2 \
    python3

RUN mkdir -p /opt/xlinkkai
RUN curl -L -o /tmp/xlinkkai.tar.gz https://dist.teamxlink.co.uk/linux/debian/static/standalone/release/amd64/xlinkkai_7.4.45_651430714_standalone_x86_64.tar.gz && \
    tar -xzf /tmp/xlinkkai.tar.gz -C /opt/xlinkkai --strip-components=1 && \
    chmod +x /opt/xlinkkai/kaiengine

COPY run.sh /run.sh
COPY web /web
RUN chmod +x /run.sh

EXPOSE 8099

CMD ["/run.sh"]
