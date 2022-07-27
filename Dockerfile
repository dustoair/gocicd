FROM alpine:3.15.5
LABEL Description="test for cicd golang"
MAINTAINER me <mememe>
#RUN echo 'https://mirrors.cloud.tencent.com/alpine/v3.13/main' > /etc/apk/repositories \
#    && echo 'https://mirrors.cloud.tencent.com/alpine/v3.13/community' >>/etc/apk/repositories \
#    && apk update && apk add tzdata && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
#    && echo "Asia/Shanghai" > /etc/timezone
RUN apk update && apk add tzdata && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
WORKDIR /app
ARG TARGETOS=linux
ARG TARGETARCH=amd64
ARG PORT=8080
COPY build/biz_${TARGETOS}_${TARGETARCH} /app/biz.bin
RUN chmod -R 777 /app
#USER nonroot:nonroot
EXPOSE 8080
ENTRYPOINT ["/app/biz.bin"]