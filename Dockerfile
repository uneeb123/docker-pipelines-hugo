FROM alpine:3.7

# Install packages needed to build
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    python3 \
    wget \
  && pip3 install --upgrade pip \
  && pip3 install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.55.6
ARG HUGO_SHA256=39d3119cdb9ba5d6f1f1b43693e707937ce851791a2ea8d28003f49927c428f4

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
                -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo* \
