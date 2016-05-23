FROM ubuntu:14.04

MAINTAINER Pascal Nagel <nagel@porus.org>

RUN apt-get -y update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. curl and lynx-cur are for debugging the container. 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur

# Enable apache mods. 
RUN a2enmod php5
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data 
ENV APACHE_RUN_GROUP www-data 
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid 

EXPOSE 80 443 

RUN a2ensite 000-default.conf
RUN a2ensite porus.org.conf
RUN a2ensite sphinexhotels.com.conf
RUN a2ensite ezdoc.de.conf
RUN a2ensite bioron.net.conf
RUN a2ensite bioron.de.conf
RUN a2ensite chefbucket.com.conf

# By default, simply start apache. 
CMD /usr/sbin/apache2ctl -D FOREGROUND
