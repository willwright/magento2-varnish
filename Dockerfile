FROM varnish:7.0

MAINTAINER Will Wright <will@magesmith.com>

#
#   Inject config files at the end to optimize build cache
#
COPY etc/varnish/varnish.vcl /etc/varnish/varnish.vcl