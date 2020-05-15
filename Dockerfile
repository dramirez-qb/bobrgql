FROM golang:alpine as builder
RUN mkdir /build
ADD . /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o bobrgql .

FROM scratch
COPY --from=builder /build/bobrgql /app/
ENV APP_PORT=8080
LABEL maintainer="Daniel Ramirez <dxas90@gmail.com>"
ENTRYPOINT [ "/app/bobrgql" ]
