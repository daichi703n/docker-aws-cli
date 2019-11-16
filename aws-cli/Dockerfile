FROM alpine:latest
LABEL maintainer "Daichi Kimura <daichi703n@gmail.com>"

RUN apk --update --no-cache add \
    py-pip \
    python \
    groff \
    jq

RUN pip install --no-cache-dir awscli && \
    apk -v --purge del py-pip && \
    rm -rf /usr/lib/python2.7/site-packages/awscli/examples

CMD sh -c "cat /etc/alpine-release; aws --version"
