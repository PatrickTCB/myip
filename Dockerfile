FROM php:apache
COPY ./app/ /var/www/html/
#COPY ports.conf /etc/apache2/ports.conf
#COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf
EXPOSE 80
