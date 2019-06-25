#!/bin/sh

set -e

# Checks for USER variable
if [ -z "$USER" ]; then
  echo >&2 'Please set an USER variable (ie.: -e USER=john).'
  exit 1
fi

# Checks for PASSWORD variable
if [ -z "$PASSWORD" ]; then
  PASSWORD=$(date +%s%N%c | sha512sum | base64 | tr -d '\n')
fi

echo "Creating user ${USER}"
adduser -D ${USER} && echo "${USER}:${PASSWORD}" | chpasswd
HOMEDIR="/home/${USER}"

echo "Fixing permissions for user ${USER}"
chown -R ${USER}:${USER} ${HOMEDIR}

if [ -z "$AUTHORIZED_KEYS" ]; then
  echo 'AUTHORIZED_KEYS variable not set (ie.: -e AUTHORIZED_KEYS="ssh-rsa AAA..."'
else
  echo 'Adding authorized_keys.'
  mkdir -p ${HOMEDIR}/.ssh
  echo "$AUTHORIZED_KEYS" > ${HOMEDIR}/.ssh/authorized_keys
  chmod 700 ${HOMEDIR}/.ssh
  chmod 600 ${HOMEDIR}/.ssh/*
  chown -R ${USER}:${USER} ${HOMEDIR}/.ssh
fi

exec "$@"
