#!/bin/bash
### Install Tomcat 9 + JRE8 on Ubuntu, Debian, CentOS, OpenSUSE 64Bits

# Check if user has root privileges
if [[ $EUID -ne 0 ]]; then
echo "You must run the script as root or using sudo"
   exit 1
fi

## Update packages
sudo apt-get update

## Install wget
sudo apt-get install wget

groupadd tomcat && useradd -M -s /bin/nologin -g tomcat -d /usr/local/tomcat tomcat

sudo apt-get install default-jdk

cd /usr/local/
wget https://apache.panu.it/tomcat/tomcat-9/v9.0.33/bin/apache-tomcat-9.0.33.tar.gz
tar -xvf apache-tomcat-9.0.33.tar.gz
mv apache-tomcat-9.0.33 tomcat
rm -f apache-tomcat-9.0.33.tar.gz

cd /usr/local/tomcat
chgrp -R tomcat conf
chmod g+rwx conf
chmod g+r conf/*
chown -R tomcat webapps/ work/ temp/ logs/
chown -R tomcat:tomcat *
chown -R tomcat:tomcat /usr/local/tomcat


echo '# Systemd unit file for tomcat
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment=”JAVA_HOME=/usr/local/java”
Environment=”CATALINA_PID=/usr/local/tomcat/temp/tomcat.pid”
Environment=”CATALINA_HOME=/usr/local/tomcat”
Environment=”CATALINA_BASE=/usr/local/tomcat”
Environment=”CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC”
Environment=”JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom”


ExecStart=/usr/local/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/tomcat.service
 
 
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
