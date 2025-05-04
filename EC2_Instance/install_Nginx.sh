#!/bin/bash 
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx 
sudo systemctl status nginx 

echo "<h1>NGINX installation completed successfully!</h1>" > /var/www/html/index.html
