#!/bin/bash

# Replace this with your domain
DOMAIN=`echo $1 | cut -f2- -d.`

#USER_DATA=`/usr/bin/curl -s http://169.254.169.254/latest/user-data`
HOSTNAME=`echo $1 | cut -f1 -d.`
IPV4=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/public-ipv4`

# Set the host name
hostname $HOSTNAME
echo $HOSTNAME > /etc/hostname

# Add fqdn to hosts file
cat<<EOF >> /etc/hosts
$IPV4 $HOSTNAME.$DOMAIN $HOSTNAME
EOF
