FROM alpine:latest
LABEL maintainer "Daichi Kimura <daichi703n@gmail.com>"

ARG AWSCLI_VERSION

RUN apk --update --no-cache add \
    python3 \
    groff \
    jq && \
    pip3 install --upgrade --no-cache-dir pip

RUN pip install --no-cache-dir awscli==$AWSCLI_VERSION && \
    pip list awscli | grep awscli | awk -F' ' '{print $2}' > awscli-release && \
    pip uninstall -y --no-cache-dir pip && \
    rm -rf /usr/lib/python*/site-packages/awscli/examples

CMD sh -c "cat /etc/alpine-release; aws --version"
