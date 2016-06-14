FROM ubuntu:14.04

MAINTAINER Pascal Nagel <nagel@porus.org>

RUN apt-get -y update
RUN apt-get -y upgrade

# Install apache, PHP, and supplimentary programs. curl and lynx-cur are for debugging the container. 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc php5-curl curl lynx-cur ssmtp mailutils

# Enable apache mods. 
RUN a2enmod php5
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data 
ENV APACHE_RUN_GROUP www-data 
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid 

EXPOSE 80 443 3306 

ADD apache2.conf /etc/apache2/
ADD php.ini /etc/php5/apache2/
ADD porus.org.conf /etc/apache2/sites-available/
ADD webmail.bioron.net.conf /etc/apache2/sites-available/
ADD bioron.net.conf /etc/apache2/sites-available/
ADD bioron.de.conf /etc/apache2/sites-available/
ADD sphinexhotels.com.conf /etc/apache2/sites-available/
ADD ezdoc.de.conf /etc/apache2/sites-available/
ADD chefbucket.com.conf /etc/apache2/sites-available/
COPY bioron-diagnostics.com.conf /etc/apache2/sites-available/bioron-diagnostics.com.conf 
COPY bioron-diagnostics.net.conf /etc/apache2/sites-available/bioron-diagnostics.net.conf
COPY bioron-diagnostics.de.conf /etc/apache2/sites-available/bioron-diagnostics.de.conf

COPY ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY revaliases /etc/ssmtp/revaliases

RUN a2ensite 000-default.conf
RUN a2ensite porus.org.conf
RUN a2ensite sphinexhotels.com.conf
RUN a2ensite ezdoc.de.conf
RUN a2ensite webmail.bioron.net.conf
RUN a2ensite bioron.net.conf
RUN a2ensite bioron.de.conf
RUN a2ensite chefbucket.com.conf
RUN a2ensite bioron-diagnostics.com.conf
RUN a2ensite bioron-diagnostics.net.conf
RUN a2ensite bioron-diagnostics.de.conf

# By default, simply start apache. 
CMD /usr/sbin/apache2ctl -D FOREGROUND
