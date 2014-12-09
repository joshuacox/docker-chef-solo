#!/bin/bash
/etc/init.d/mysql stop
/usr/bin/mysqld_safe --skip-grant-tables &
sleep 10
# Generate random passwords
DRUPAL_DB="drupal"
MYSQL_PASSWORD=`pwgen -c -n -1 12`
DRUPAL_PASSWORD=`pwgen -c -n -1 12`
# This is so the passwords show up in logs.
echo mysql root password: $MYSQL_PASSWORD
echo drupal password: $DRUPAL_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $DRUPAL_PASSWORD > /drupal-db-pw.txt
#mysqladmin -u root password $MYSQL_PASSWORD
mysql -h localhost -u root mysql -e "update user set Password=PASSWORD('$MYSQL_PASSWORD') WHERE User='root'"
/etc/init.d/mysql stop
/usr/bin/mysqld_safe &
sleep 3
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE drupal; GRANT ALL PRIVILEGES ON drupal.* TO 'drupal'@'localhost' IDENTIFIED BY '$DRUPAL_PASSWORD'; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "show grants for drupal@localhost;"
#sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-available/default
#a2enmod rewrite vhost_alias
a2enmod vhost_alias
cd /var/www/
if [ -f /home/drush-archive.tar.gz ]; then
  echo "DRUPAL-INSTALL from BACKUP /home/drush-archive.tar.gz"
  # Have your own archive to restore from? supply it in /home/
  rm -Rf /var/www/*
  cd /var/www/
  drush archive-restore --db-url="mysqli://drupal:${DRUPAL_PASSWORD}@localhost:3306/drupal" --overwrite --destination=/var/www/ /home/drush-archive.tar.gz
else
  echo 'DRUPAL-INSTALL from -->>>| D R U S H |<<<---'
  drush site-install standard -y --account-name=admin --account-pass=admin --db-url="mysqli://drupal:${DRUPAL_PASSWORD}@localhost:3306/drupal"
fi
  chmod a+w /var/www/sites/default
  mkdir /var/www/sites/default/files
  chown -R www-data. /var/www
  killall mysqld
  cat "/ddd.txt"
  sleep 10
supervisord -n -c /etc/supervisord.conf
