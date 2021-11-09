FROM alpine:latest
WORKDIR /usr/local/
COPY x-ui.sh /usr/local/x-ui.sh
RUN apk update && \
    apk add --no-cache tzdata runit && \
    mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    wget -q https://github.com/vaxilu/x-ui/releases/download/0.3.2/x-ui-linux-amd64.tar.gz && \
    tar -zxvf x-ui-linux-amd64.tar.gz && \
    rm x-ui-linux-amd64.tar.gz && \
    mv x-ui.sh x-ui/x-ui.sh && \
    cd x-ui && \
    chmod +x x-ui bin/xray-linux-amd64 x-ui.sh && \
    cp -f x-ui.sh /usr/bin/x-ui.sh && \
    rm -rf /var/cache/apk/*

COPY runit /etc/service
WORKDIR /usr/local/x-ui
CMD [ "runsvdir", "-P", "/etc/service"]
