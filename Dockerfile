FROM alpine:3.14

ARG GOKART_VERSION="0.3.0"

LABEL com.github.actions.name="GoKart Scanner"
LABEL com.github.actions.icon="check"
LABEL com.github.actions.color="green"
LABEL com.github.actions.description="Scan your Golang code for vulnerabilities with GoKart"

LABEL maintainer="iamralch"
LABEL repository="https://github.com/phogolabs/gokart-action"
LABEL description="Scan your Golang code for vulnerabilities with GoKart"

# add the required packages
RUN apk add --no-cache bash=5.1.4-r0 findutils=4.8.0-r1 git=2.32.0-r0 go=1.16.8-r0
# download gokart
ADD https://github.com/praetorian-inc/gokart/releases/download/v${GOKART_VERSION}/gokart_${GOKART_VERSION}_linux_x86_64.tar.gz /tmp/gokart.tar.gz
# unpack the package
RUN tar -xzf /tmp/gokart.tar.gz -C /bin && rm /tmp/gokart.tar.gz && chmod +x /bin/gokart
# enable the entry point
COPY main.sh /bin/main
# make sure that the entry point has the correct attributes
RUN chmod +x /bin/main

ENTRYPOINT ["main"]
