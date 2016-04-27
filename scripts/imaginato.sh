# Nginx Configuration

# OMS QRAVED Config
echo "Configuring OMS Qraved VHosts"
sudo mkdir -p /var/www/logs/
sudo touch /var/www/logs/oms_qraved-site.access.log
cp /home/vagrant/code/provision/config/oms_qraved /etc/nginx/sites-available/oms_qraved > /dev/null
ln -s /etc/nginx/sites-available/oms_qraved /etc/nginx/sites-enabled/

# ROOANG Config
echo "Configuring ROOANG VHosts"
sudo touch /var/www/logs/imaginato_rooang_oc.access.log
cp /home/vagrant/code/provision/config/rooang /etc/nginx/sites-available/rooang > /dev/null
ln -s /etc/nginx/sites-available/rooang /etc/nginx/sites-enabled/

# QRAVED Config
echo "Configuring Qraved VHosts"
sudo mkdir -p /var/www/logs/
sudo touch /var/www/logs/qraved-site.access.log
cp /home/vagrant/code/provision/config/qraved /etc/nginx/sites-available/qraved > /dev/null
ln -s /etc/nginx/sites-available/qraved /etc/nginx/sites-enabled/

sudo chown www-data:root -R /var/www/logs/*