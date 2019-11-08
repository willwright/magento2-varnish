FROM ubuntu:18.04

MAINTAINER Will Wright <will@magesmith.com>

# disable interactive functions
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
apt-get install -y curl apt-transport-https telnet curl gnupg

RUN curl -L https://packagecloud.io/varnishcache/varnish63/gpgkey | apt-key add -
RUN echo "deb https://packagecloud.io/varnishcache/varnish63/ubuntu/ bionic main" >> /etc/apt/sources.list.d/varnishcache_varnish63.list
RUN echo "deb-src https://packagecloud.io/varnishcache/varnish63/ubuntu/ bionic main" >> /etc/apt/sources.list.d/varnishcache_varnish63.list
RUN apt-get update && \
apt-get install -y varnish

#
#   Inject config files at the end to optimize build cache
#
COPY etc/varnish/default.vcl /etc/varnish/default.vcl
COPY etc/varnish/varnish.vcl /etc/varnish/varnish.vcl

CMD ["/usr/sbin/varnishd","-F","-f","/etc/varnish/varnish.vcl","-s","malloc,2048M","-p","http_resp_hdr_len=90000","-p","thread_pool_min=5","-p","thread_pool_timeout=600","-p","http_max_hdr=200","-p","http_resp_size=9000k","-p","workspace_backend=9000k"]