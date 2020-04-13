#!/bin/bash

# Update OS
yum update -y --exclude-kernel

# Add dev utils
yum install -y vim unzip git screen

# Install Apache
yum install -y httpd httpd-devel httpd-tools
systemctl enable httpd
systemctl start httpd

rm -rf /var/www/html
ln -s /vagrant /var/www/html

systemctl start httpd

# Install PHP
yum install -y php php-cli php-common php-mysql

# Install mysql
yum install -y mysql mysql-server mysql-devel
systemctl enable mysql
systemctl start mysqld

mysql -u root -e "SHOW DATABASES";

# Download starter content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/rbkaspr/vagrant-lamp-demo/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/rbkaspr/vagrant-lamp-demo/master/files/info.php

systemctl restart httpd
