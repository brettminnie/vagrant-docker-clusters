FROM haproxy:1.8

ARG HAPROXY_USER=haproxy

RUN groupadd --system ${HAPROXY_USER}; \
    useradd --system --gid ${HAPROXY_USER} ${HAPROXY_USER}; \
    mkdir -p /var/lib/haproxy

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
