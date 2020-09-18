FROM alpine:3.12

RUN apk add --no-cache gnupg bash

COPY verify.sh /usr/local/bin/verify
RUN chmod +x /usr/local/bin/verify

RUN mkdir /verify
WORKDIR /verify

ENTRYPOINT ["/usr/local/bin/verify"]
