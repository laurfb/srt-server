FROM alpine:latest as build

#Up-to-date
RUN apk update
RUN apk upgrade
RUN apk add --no-cache tcl linux-headers alpine-sdk cmake git openssl-dev zlib-dev

#Clone projects
WORKDIR /tmp
RUN git clone https://github.com/Haivision/srt.git
RUN git clone https://github.com/laurfb/srt-server.git

#Build SRT
WORKDIR /tmp/srt 
RUN ./configure --prefix=/usr
RUN make
RUN make install

#Build srt-server
WORKDIR /tmp/srt-server
RUN cmake .
RUN make
RUN make install

#Define work points
VOLUME /logs
WORKDIR /usr/local/bin
ENTRYPOINT ["srt-server"]
