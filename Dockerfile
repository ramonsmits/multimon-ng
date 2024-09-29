FROM debian:buster-slim AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y install cmake gcc make 

RUN mkdir -p /app/build
ADD . /app
WORKDIR /app/build
RUN cmake .. && make

FROM debian:buster-slim

RUN apt-get -y update && apt-get -y install sox

COPY --from=build /app/build/multimon-ng /usr/bin/
ENTRYPOINT ["/usr/bin/multimon-ng"]
