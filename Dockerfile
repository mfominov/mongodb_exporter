FROM golang:1.11.2-stretch as build
LABEL maintainer="Maksim Fominov"

WORKDIR /go/src/github.com/percona/mongodb_exporter

COPY . .
RUN make 

FROM quay.io/prometheus/busybox:latest
LABEL maintainer="Maksim Fominov"

COPY --from=build /go/src/github.com/percona/mongodb_exporter/mongodb_exporter /bin/mongodb_exporter 

EXPOSE      9216
ENTRYPOINT  [ "/bin/mongodb_exporter" ]
