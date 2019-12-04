FROM alpine:3.7

RUN apk add curl
RUN apk add nginx

RUN wget https://releases.hashicorp.com/consul-template/0.23.0/consul-template_0.23.0_linux_amd64.zip
RUN unzip consul-template_0.23.0_linux_amd64.zip

RUN apk add bash

ENV CONSUL_HTTP_ADDR="http://192.168.0.21:8500"

RUN mkdir -p /etc/nginx/conf.d.template/
COPY load-balancer.conf.ctmpl /etc/nginx/conf.d.template/load-balancer.conf.ctmpl

COPY consul-template-config.hcl consul-template-config.hcl

RUN mkdir -p /run/nginx

CMD nginx && ./consul-template -config=consul-template-config.hcl
#CMD bash