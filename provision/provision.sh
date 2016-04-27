#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -q

echo "Installing PHP"
sudo apt-get install -q -y -f php5-common php5-dev php5-cli php5-fpm mysql-server-5.5 > /dev/null

# Install mysql, nginx, php5-fpm
sudo apt-get install -q -y -f mysql-server mysql-client nginx php5-sqlite php5-mysqlnd

# Force a blank root password for mysql (changed into "secret")
echo "mysql-server mysql-server/root_password password 1234" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password 1234" | debconf-set-selections

# Install commonly used php packages
sudo apt-get install -q -y -f curl php5-curl php5-memcached php5-gd php-pear php5-imagick php5-mcrypt php5-apcu
sudo php5enmod mcrypt

# Install Node.js v6
echo "Install Node.js v6..."
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -q -y -f nodejs build-essential

#Install Gulp
#echo "Install Gulp..."
#sudo npm install -g yo gulp bower

# Install Git
echo "Install Git..."
sudo apt-get install -q -y -f git

# Install ZAH
echo "Installing ZSH..."
sudo apt-get install -q -y -f zsh

# Install The Fuck
# app which corrects your previous console command.
sudo apt-get install -q -y -f python3-dev python3-pip
sudo -H pip3 install thefuck

#add fuck alias if not already exists in .bashrc
grep -q -F 'alias fuck' /home/vagrant/.bashrc || echo "$(thefuck --alias)" >> /home/vagrant/.bashrc
source ~/.bashrc

/home/vagrant/code/scripts/adminer.sh
/home/vagrant/code/scripts/ajenti.sh

echo "Setting nginx..."
sudo rm /etc/nginx/sites-available/default
sudo touch /etc/nginx/sites-available/default

sudo cat >> /etc/nginx/sites-available/default <<'EOF'
server {
  listen   80;

  root /var/www;
  index index.php index.html index.htm;

  # Make site accessible from http://localhost/
  server_name _;

  location / {
    # First attempt to serve request as file, then
    # as directory, then fall back to index.html
    try_files $uri $uri/ /index.html;
  }

  location /doc/ {
    alias /usr/share/doc/;
    autoindex on;
    allow 127.0.0.1;
    deny all;
  }

  # redirect server error pages to the static page /50x.html
  #
  error_page 500 502 503 504 /50x.html;
  location = /50x.html {
    root /usr/share/nginx/html;
  }

  # pass the PHP scripts to FastCGI server listening on /tmp/php5-fpm.sock
  #
  location ~ \.php$ {
    try_files $uri =404;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    fastcgi_index index.php;
    include fastcgi_params;
  }

  # deny access to .htaccess files, if Apache's document root
  # concurs with nginx's one
  #
  location ~ /\.ht {
    deny all;
  }

}
EOF

#sudo apt-get install -q -y -f phpmyadmin

/home/vagrant/code/scripts/imaginato.sh

sudo service nginx restart > /dev/null

sudo service php5-fpm restart

echo "Setting up ssh auth keys..."
sudo cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys

echo "Finished provisioning."