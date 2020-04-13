#!/bin/bash
# Update OS
yum update -y --exclude=kernel

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


