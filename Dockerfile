FROM ubuntu:22.04

RUN apt-get update
RUN apt install -y nginx git
RUN rm -rf /var/www/html/*
RUN git clone https://github.com/dariakalugny/Project-DevOps.git /var/www/html/

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]