FROM ubuntu:16.04

MAINTAINER wwright <wwrig@guidance.com>

# disable interactive functions
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
apt-get install -y curl apt-transport-https telnet

#RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add -
#RUN echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update && \
apt-get install -y varnish

#
#   Inject config files at the end to optimize build cache
#
COPY etc/varnish/default.vcl /etc/varnish/default.vcl
COPY etc/varnish/varnish.vcl /etc/varnish/varnish.vcl

CMD ["/usr/sbin/varnishd","-F","-f","/etc/varnish/varnish.vcl","-s","malloc,2048M","-p","http_resp_hdr_len=90000","-p","thread_pool_min=5","-p","thread_pool_timeout=600","-p","http_max_hdr=200","-p","http_resp_size=9000k","-p","workspace_backend=9000k"]