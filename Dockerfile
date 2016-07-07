FROM ubuntu:14.04.4 
MAINTAINER Mandus Momberg <mandus@momberg.me>

ENV DB_HOST="localhost" DB_PORT="3306" DB_USER="poweradmin" DB_PASSWORD="powerAdmin2016"

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y curl git software-properties-common

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
add-apt-repository "deb http://dl.hhvm.com/ubuntu $(lsb_release -sc) main"

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install hhvm nginx
RUN /usr/share/hhvm/install_fastcgi.sh
RUN sed -i 's/user www-data;/user www-data;\ndaemon off;/' /etc/nginx/nginx.conf

RUN git clone https://github.com/poweradmin/poweradmin.git /tmp/poweradmin && cd /tmp/poweradmin && \
git checkout -b v2.1.7 v2.1.7 && \
rm -f /usr/share/nginx/html/* && \
cp -r /tmp/poweradmin/* /usr/share/nginx/html/ && \
cp /usr/share/nginx/html/inc/config-me.inc.php /usr/share/nginx/html/inc/config.inc.php

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ['/docker-entrypoint.sh']