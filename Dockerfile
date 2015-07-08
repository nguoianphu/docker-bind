### Dockerfile for install ISC BIND DNS

### I like CentOS
FROM centos

MAINTAINER nguoianphu@gmail.com

### Some env variables
ENV DATA_DIR=/data \
    BIND_USER=bind

RUN yum clean all \
 && yum -y update \
 ### Install BIND
 && yum install bind* -y
 ### Install 3rd party libs
 ### OpenSSL Dev
 && yum -y install openssl openssl-devel \
 ### Libxml2 Dev
 && yum -y install libxml2 libxml2-devel \
 ### Kerberos Dev
 && yum -y install krb5-devel \
 ### Webmin GUI
 && cp -f webmin.repo /etc/yum.repos.d/webmin.repo \
 && wget "http://www.webmin.com/jcameron-key.asc" -P /tmp/ \
 && rpm --import /tmp/jcameron-key.asc \
 && yum -y install webmin \
 && rm -rf /tmp/jcameron-key.asc \
 && yum clean all \
 ### Install tool for compiling
 && yum -y install gcc \
 && yum -y install wget \
 && yum -y install perl \
 && yum -y install python

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 10000/tcp
VOLUME ["${DATA_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
