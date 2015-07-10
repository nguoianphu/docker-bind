### Dockerfile for install ISC BIND DNS

### I like CentOS
FROM centos:latest

MAINTAINER nguoianphu@gmail.com

### Some env variables
ENV DATA_DIR=/data \
    BIND_USER=bind

RUN yum clean all \
 && yum -y update \
 ### Install BIND
 && yum -y install bind \
 ### Install 3rd party libs
 ### OpenSSL Dev
 #&& yum -y install openssl openssl-devel \
 ### Libxml2 Dev
 #&& yum -y install libxml2 libxml2-devel \
 ### Kerberos Dev
 #&& yum -y install krb5-devel \
 ### Install tool for compiling
 #&& yum -y install gcc \
 #&& yum -y install wget \
 #&& yum -y install perl \
 #&& yum -y install python \
 && yum clean all
 ### Start BIND
 #&& /usr/sbin/named 

### Webmin GUI
# COPY webmin.repo /etc/yum.repos.d/webmin.repo
#RUN  wget "http://www.webmin.com/jcameron-key.asc" -P /tmp/ \
# && rpm --import /tmp/jcameron-key.asc \
# && yum -y install webmin \
# && rm -rf /tmp/jcameron-key.asc \
# && yum clean all
#COPY entrypoint.sh /sbin/entrypoint.sh
# RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 10000/tcp
#VOLUME ["${DATA_DIR}"]
# ENTRYPOINT ["/sbin/entrypoint.sh"]
