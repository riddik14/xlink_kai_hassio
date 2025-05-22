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
RUN curl -L -o /tmp/kaiEngine.zip https://downloads.teamxlink.co.uk/binary/kaiEngine-7.4.40-linux.zip && \
    unzip /tmp/kaiEngine.zip -d /opt/xlinkkai && \
    chmod +x /opt/xlinkkai/kaiEngine

COPY run.sh /run.sh
COPY web /web
RUN chmod +x /run.sh

EXPOSE 8099

CMD [ "/run.sh" ]
