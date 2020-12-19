#!/bin/bash

echo %vagrant ALL=NOPASSWD:ALL >/etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
usermod -a -G sudo vagrant

# update & upgrade system
sudo apt-get update
sudo apt-get upgrade

# install apache2
sudo apt-get install apache2 -y
sudo a2enmod headers

# create website config
echo "
  <VirtualHost *:80>
      DocumentRoot \"/var/www/html/public\"
      Header set X-Frame-Options: \"sameorigin\"
      ServerName sinica_tigp.vm
      ServerAlias sinica_tigp.vm
      ErrorLog \"/var/log/apache2/sinica_tigp.vm_error-log\"
      CustomLog \"/var/log/apache2/sinica_tigp.vm_access_log\" common
      TraceEnable On
      SetEnv APPLICATION_ENV \"development\"
      <Directory \"/var/www/html/public\">
          AllowOverride All
          Options Indexes MultiViews FollowSymLinks
          Require all granted
      </Directory>
  </VirtualHost>
  " >/etc/apache2/sites-available/000-default.conf

# add repository
sudo apt-add-repository ppa:ondrej/php

# install tool
sudo apt install -y libpng-dev
sudo apt install -y zip
sudo apt install -y apt-utils
sudo apt-get install -y wkhtmltopdf
sudo apt-get install -y xvfb
sudo apt-get install -y fonts-wqy-microhei ttf-wqy-microhei fonts-wqy-zenhei ttf-wqy-zenhei
sudo apt install -y ghostscript

# install mongodb
sudo apt install -y mongodb

# install php 7.4
sudo apt-get install php7.4 -y
sudo apt-get install php7.4-mysql php7.4-gd php7.4-curl php7.4-json php7.4-cgi php7.4-xml php7.4-zip php7.4-mbstring php7.4-mongodb -y

# install font for pdf
sudo apt-get install xfonts-75dpi xfonts-100dpi xfonts-scalable xfonts-cyrillic xfonts-intl-chinese xfonts-intl-chinese-big xfonts-wqy xfonts-75dpi-transcoded xfonts-100dpi-transcoded

# install xdebug
sudo apt-get install -y php-xdebug

# add apache2 module
sudo ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

# update php.ini
sudo sed -e 's/^;date\.timezone =/date\.timezone ="Asia\/Taipei"/' -i /etc/php/7.4/apache2/php.ini
sudo sed -i "s/short_open_tag = .*/short_open_tag = On/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s/track_errors = .*/track_errors = On/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.4/apache2/php.ini
sudo sed -i "s/zend.assertions = .*/zend.assertions = 1/" /etc/php/7.4/apache2/php.ini
sudo echo "zend_extension=/usr/lib/php/20190902/xdebug.so" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_port=9999" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_enable=1" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_connect_back=0" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_autostart=1" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_host=10.0.2.2" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.max_nesting_level=1000" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.idekey=PHPSTORM" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.default_enable=1" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_mode = req" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_handler=dbgp" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.remote_log=\"/var/log/xdebug/xdebug.log\"" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.force_display_errors=On" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.force_error_reporting=E_ALL" >>/etc/php/7.4/apache2/php.ini
sudo echo "xdebug.show_error_trace=On" >>/etc/php/7.4/apache2/php.ini

# move wkhtmltopdf tool
sudo cp /usr/bin/wkhtmlto* /usr/local/bin/

# set datetime
sudo timedatectl set-timezone Asia/Taipei

# restart apache2
sudo systemctl restart apache2

# delete origin index.html
cd /var/www/html
sudo rm index.html