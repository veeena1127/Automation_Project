#!/bin/bash
sudo apt update -y
if [ -z $(apt list --installed |grep  -o 'apache2*'|head -1) ];
then
		sudo apt-get install apache2 -y
fi
if [ $(systemctl status apache2 | grep  'Active: inactive (dead)') ];
        then
		systemctl start apache2;
fi
if [ -z $(systemctl is-enabled apache2 | grep 'enabled') ];
        then
		systemctl enable apache2;
fi
name="Veena";
timestamp=$(date '+%d%m%Y-%H%M%S')
cd /var/log/apache2/
tar -czvf $name-httpd-logs-$timestamp.tar *.log
cp /var/log/apache2/$name-httpd-logs-$timestamp.tar *.log /tmp/
aws s3 cp /tmp/$name-httpd-logs-$timestamp.tar s3://upgrad-veena/
exit 1
