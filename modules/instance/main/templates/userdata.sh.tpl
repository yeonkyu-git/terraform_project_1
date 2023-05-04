#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

IP_ADDR=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
sudo echo "<h1>HELLO</h1> <p>SERVER IP : $IP_ADDR</p>" >> /var/www/html/index.html
sudo chown -R root:root /var/www