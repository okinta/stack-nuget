FROM okinta/s3proxy

COPY files /

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
CMD ["/usr/bin/openresty", "-g", "daemon off;"]
