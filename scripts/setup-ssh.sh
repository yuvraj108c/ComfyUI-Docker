#!/bin/bash

apt update && apt install -y openssh-server
mkdir /var/run/sshd

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config