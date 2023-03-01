FROM alpine:latest as build

#Up-to-date
RUN apk update && apk upgrade && apk add --no-cache tcl linux-headers alpine-sdk cmake git openssl-dev zlib-dev

#Clone projects
WORKDIR /tmp
RUN git clone https://github.com/Haivision/srt.git && git clone https://github.com/laurfb/srt-server.git

#Build SRT
WORKDIR /tmp/srt 
RUN ./configure --prefix=/usr && make && make install

#Build srt-server
WORKDIR /tmp/srt-server
RUN cmake . && make && make install

#Define work points
VOLUME /logs
WORKDIR /usr/local/bin
ENTRYPOINT ["srt-server"]
