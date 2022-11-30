FROM alpine:3.14

ARG APP_VERSION="0.3.0"
ARG APP_NAME="GoKart Scanner"
ARG APP_DESCRIPTION="Scan your Golang code for vulnerabilities with GoKart"
ARG APP_SOURCE="https://github.com/phogolabs/gokart-action"

LABEL com.github.actions.name=$APP_NAME
LABEL com.github.actions.icon="check"
LABEL com.github.actions.color="green"
LABEL com.github.actions.description=$APP_DESCRIPTION

LABEL org.opencontainers.image.title=$APP_NAME
LABEL org.opencontainers.image.version=$APP_VERSION
LABEL org.opencontainers.image.description=$APP_DESCRIPTION
LABEL org.opencontainers.image.source=$APP_SOURCE

# add the required packages
RUN apk add --no-cache bash=5.1.16-r0 findutils=4.8.0-r1 git=2.32.4-r0 go=1.16.15-r0
# download gokart
ADD https://github.com/praetorian-inc/gokart/releases/download/v${APP_VERSION}/gokart_${APP_VERSION}_linux_x86_64.tar.gz /tmp/gokart.tar.gz
# unpack the package
RUN tar -xzf /tmp/gokart.tar.gz -C /usr/bin && rm /tmp/gokart.tar.gz && chmod +x /usr/bin/gokart
# enable the entry point
COPY main.sh /usr/bin/main
# make sure that the entry point has the correct attributes
RUN chmod +x /usr/bin/main
# copy the configuration
COPY gokart.yaml /etc/gokart.yaml

ENTRYPOINT ["/usr/bin/main"]
