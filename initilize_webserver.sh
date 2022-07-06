# initilize_webserver.sh
# Script to initialize simple webserver for Cyara

#!/bin/bash

SERVERNAME=phil-web-001
WEBREPO=https://github.com/ozcrn/html-template
DISTRO=$(grep ID_LIKE /etc/*-release | awk -F'=' '{print $2}')

#Set hostname of server to SERVERNAME
hostnamectl set-hostname $SERVERNAME

#Install git/nginx and set to nginx to start on boot
if [[ "$DISTRO" == "debian" ]]; then
  apt-get update
  apt-get install -y nginx git
  systemctl enable nginx
  systemctl start nginx
else
  yum install nginx git -y
  systemctl enable nginx
  systemctl start nginx
fi

#Clone repo with html template to tmp directory and copy to webserver root
git -C /tmp/ clone $WEBREPO
if [[ "$DISTRO" == "debian" ]]; then
  cp /tmp/html-template/template.html /var/www/html/index.html
else
  cp /tmp/html-template/template.html /usr/share/nginx/html/index.html
fi

#update index.html with hostname and IP address
if [[ "$DISTRO" == "debian" ]]; then
  sed -i s/HOSTNAME/$(hostname)/ /var/www/html/index.html
  sed -i s/IPADDRESS/$(ip route get 1 | awk 'NR==1{print $7}')/ /var/www/html/index.html
else
  sed -i s/HOSTNAME/$(hostname)/ /usr/share/nginx/html/index.html
  sed -i s/IPADDRESS/$(ip route get 1 | awk 'NR==1{print $7}')/ /usr/share/nginx/html/index.html
fi

