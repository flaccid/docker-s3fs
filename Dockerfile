FROM alpine:3.8 as builder

ARG S3FS_VERSION=v1.84

WORKDIR /tmp

RUN apk --update --no-cache add \
      fuse \
      libcurl \
      libxml2 \
      build-base \
      automake \
      autoconf \
      libxml2-dev \
      fuse-dev \
      curl-dev \
      curl && \
      curl -SsL https://github.com/s3fs-fuse/s3fs-fuse/archive/${S3FS_VERSION}.tar.gz > s3fs.tar.gz && \
      tar zxvf s3fs.tar.gz && \
      cd s3fs-fuse-* && \
      ./autogen.sh && \
      ./configure && \
      make && \
      make install

FROM alpine:3.8

RUN apk --update --no-cache add \
      fuse-dev \
      libcurl \
      libxml2 \
      libstdc++

COPY --from=builder /usr/local/bin/s3fs /usr/bin/s3fs

WORKDIR /usr/bin

ENTRYPOINT ["s3fs"]
