FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y install cmake gcc make 

RUN apt-get install sox -y

RUN mkdir -p /app/build
ADD . /app
WORKDIR /app/build
RUN cmake .. && make && cp ./multimon-ng /usr/bin

ENTRYPOINT ["/usr/bin/multimon-ng"]
