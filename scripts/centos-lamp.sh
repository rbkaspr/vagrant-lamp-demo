#!/bin/bash

# Update OS
yum update -y --exclude=kernel

# Add dev utils
yum install -y vim unzip git screen

# Install Apache
yum install -y httpd httpd-devel httpd-tools
systemctl enable httpd
systemctl start httpd

rm -rf /var/www/html
ln -s /vagrant /var/www/html

systemctl start httpd

# Install mysql
yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum install -y mysql mysql-server mysql-devel
systemctl enable mysqld
systemctl start mysqld

# Cleanup root password
password=$(grep -oP 'temporary password(.*): \K(\S+)' /var/log/mysqld.log)
mysqladmin --user=root --password="$password" password aaBB@@cc1122
mysql --user=root --password=aaBB@@cc1122 -e "UNINSTALL COMPONENT 'file://component_validate_password';"
mysqladmin --user=root --password="aaBB@@cc1122" password ""

mysql -u root -e "SHOW DATABASES";

# Install PHP
yum install -y php php-cli php-common php-mysql

# Download starter content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/rbkaspr/vagrant-lamp-demo/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/rbkaspr/vagrant-lamp-demo/master/files/info.php

systemctl restart httpd
