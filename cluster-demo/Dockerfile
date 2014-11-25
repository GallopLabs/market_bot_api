FROM ubuntu:14.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install curl nginx supervisor
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf && rm -f /etc/nginx/sites-enabled/*

ENV CT_URL https://github.com/hashicorp/consul-template/releases/download/v0.3.1/consul-template_0.3.1_linux_amd64.tar.gz
RUN curl -L $CT_URL | tar -C /usr/local/bin --strip-components 1 -zxf -

COPY nginx.ctmpl /etc/consul-template/nginx.ctmpl

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
