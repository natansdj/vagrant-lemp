#!/bin/sh

### Adminer ###
echo "Installing Adminer..."
sudo mkdir -p /var/www/adminer/

sudo touch /var/www/adminer/info.php
sudo cat >> /var/www/adminer/info.php <<'EOF'
<?php phpinfo(); ?>
EOF

sudo wget http://www.adminer.org/latest-en.php -O /var/www/adminer/index.php

cp /home/vagrant/code/provision/config/adminer /etc/nginx/sites-available/adminer > /dev/null
ln -s /etc/nginx/sites-available/adminer /etc/nginx/sites-enabled/