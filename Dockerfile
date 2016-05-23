FROM php:5.6-apache

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN a2ensite *.conf

EXPOSE 80
EXPOSE 443

RUN /usr/bin/install -d -o www-data -g www-data /var/log/apache2 

VOLUME /var/www/html
VOLUME /etc/apache2/sites-enabled

ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_LOG_DIR=/var/log/apache2
ENV LANG=C
