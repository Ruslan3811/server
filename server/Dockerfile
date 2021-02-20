#downloading debian
FROM debian:buster

#downloading package list from repositories and updates information about upgradings
#-y means to do action without asking user's permission
#upgrade will get new versions of packages if machine has it
RUN apt-get -y update
RUN apt-get -y upgrade
#wget gives possibility to install any resources from links
#nginx for redirecting
#mariadb-server for saving data
#net-tools are used for defeniting ip addresses 
#openssl for creating private key
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
#php-fpm allowing NGINX to give requests to PHP and php-mysql allow to interact with server part of db
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
RUN apt-get -y install net-tools
RUN apt-get -y install openssl
RUN apt-get -y install vim

COPY ./test.sh /etc/nginx/sites-available/index.sh
RUN chmod ugo+x /etc/nginx/sites-available/index.sh
#configuration nginx, deleting old conf and creating new
RUN rm /etc/nginx/sites-available/default
COPY ./src/config_nginx/config_nginx.conf /etc/nginx/sites-available/default
#making workdir
WORKDIR /var/www/html/
RUN mv index.nginx-debian.html ./..
RUN mkdir text_file
RUN mkdir return_text_file
COPY ./src/text_file/greeting.txt ./text_file
RUN mkdir images
COPY ./src/image_shrek/ ./images/
#downloading archive files
RUN wget --limit-rate=5000K https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN wget --limit-rate=5000K https://wordpress.org/latest.tar.gz
#unpack archive files
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
#rename directory, deleting old conf file and creating new for phpmyadmin
RUN mv phpMyAdmin-5.0.1-english phpmyadmin
RUN rm ./phpmyadmin/config.sample.inc.php
COPY ./src/phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php
#copy conf file
RUN rm ./wordpress/wp-config-sample.php
COPY ./src/wordpress/wp-config-sample.php ./wordpress/wp-config.php
#req -> generating request, -x509 -> generating sertificate which works itself
#-nodes -> making key without encrypt
#-days 365 -> how long key will be working
#-subj -> making information about person who has got the sertificate
#-newkey is used for creating key 
#-keyout -> we need in the parameter as we used newkey. We point path where key will be.
#-out -> where to create key
RUN openssl req -x509 -nodes -days 365 -subj "/C=RF/ST=Kazan/L=Kazan/O=innoaca/OU=school21/CN=aahri" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data *

RUN chmod -R 755 /var/www/*
#using ports
EXPOSE 80 443

COPY ./src/init.sh ./..

CMD bash ./../init.sh
