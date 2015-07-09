#!/bin/bash
set -e

# script variables
BIND_DATA_DIR=${DATA_DIR}/bind

## ...and here we go
chmod 755 ${DATA_DIR}

# create directory for bind config
mkdir -p ${BIND_DATA_DIR}
groupadd ${BIND_USER}
chown -R root:${BIND_USER} ${BIND_DATA_DIR}

# populate default bind configuration if it does not exist
if [ ! -d ${BIND_DATA_DIR}/etc ]; then
  mv /etc/bind ${BIND_DATA_DIR}/etc
fi
rm -rf /etc/bind
ln -sf ${BIND_DATA_DIR}/etc /etc/bind

if [ ! -d ${BIND_DATA_DIR}/lib ]; then
  mkdir -p ${BIND_DATA_DIR}/lib
  chown root:${BIND_USER} ${BIND_DATA_DIR}/lib
fi
rm -rf /var/lib/bind
ln -sf ${BIND_DATA_DIR}/lib /var/lib/bind

# create /var/run/named
mkdir -m 0775 -p /var/run/named
chown root:${BIND_USER} /var/run/named

if [ -z "$@" ]; then
  echo "Starting named..."
  exec /usr/sbin/named -u ${BIND_USER} -g
else
  exec "$@"
fi
