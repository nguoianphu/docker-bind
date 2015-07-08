FROM centos
MAINTAINER nguoianphu@gmail.com

ENV DATA_DIR=/data \
    BIND_USER=bind \
    WEBMIN_VERSION=1.760

RUN yum clean all \
## rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && yum -y update \
 && yum -y install gcc \
 && yum -y install wget \
 && yum -y install perl \
 && yum -y install python \
 && yum -y install openssl \
 && yum -y install libxml2 \
 && yum -y install bind9 \
 && wget "http://prdownloads.sourceforge.net/webadmin/webmin_${WEBMIN_VERSION}_all.rpm" -P /tmp/ \
 && rpm -ivh /tmp/webmin_${WEBMIN_VERSION}_all.rpm \
 && rm -rf /tmp/webmin_${WEBMIN_VERSION}_all.rpm \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 10000/tcp
VOLUME ["${DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
