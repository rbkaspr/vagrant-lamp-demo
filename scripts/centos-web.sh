#!/bin/bash
# Update OS
yum update -y --exclude=kernel
# Install Apache
yum install -y httpd httpd-devel httpd-tools
systemctl enable httpd
systemctl start httpd

rm -rf /var/www/html
ln -s /vagrant /var/www/html

systemctl start httpd

# Install mysql repo
yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm

# Install PHP
yum install -y php php-cli php-common php-mysql

# Download starter content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/rbkaspr/vagrant-lamp-demo/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/rbkaspr/vagrant-lamp-demo/master/files/info.php

sudo systemctl restart httpd
