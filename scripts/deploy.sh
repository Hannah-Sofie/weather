#!/bin/bash
##### PREVIOUS STEPS
# cd /opt/

# sudo git clone https://github.com/Hannah-Sofie/weather.git
##### 

sudo apt update
sudo apt upgrade
sudo apt install fcgiwrap

sudo systemctl enable fcgiwrap
sudo systemctl start fcgiwrap
sudo systemctl status fcgiwrap

# sudo mkdir -p /opt/weather/


sudo cp /opt/weather/config_files/weather.conf /etc/nginx/sites-available/weather.conf


sudo ln -s  /etc/nginx/sites-available/weather.conf /etc/nginx/sites-enabled/

sudo chown root:www-data -R /opt/weather/

sudo chmod 775 -R /opt/weather/PROJECT/

sudo chmod +x /opt/weather/cgi-bin/getData.cgi

sudo chmod +x /opt/weather/scripts/script03.sh

sudo nginx -t
sudo nginx -s reload

sudo cp /opt/weather/config_files/myCronTimeChecker.timer /etc/systemd/system
sudo cp /opt/weather/config_files/myCronTimeChecker.service /etc/systemd/system

sudo systemctl start myCronTimeChecker.service
sudo systemctl enable myCronTimeChecker.timer
