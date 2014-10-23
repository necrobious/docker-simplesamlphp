# simpleSAMLphp
#
# VERSION               1.0.0

FROM      ubuntu:14.04
MAINTAINER Kirk Peterson "necrobious@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

####################
# apache2 server
RUN apt-get update  -y
RUN apt-get install -y git subversion curl htop apache2 apache2-doc apache2-suexec-pristine apache2-suexec-custom apache2-utils openssl-blacklist libmcrypt-dev mcrypt php5 libapache2-mod-php5 php5-mcrypt php-pear php5-common php5-cli php5-curl php5-gmp php5-ldap libapache2-mod-gnutls simplesamlphp 
RUN a2enmod gnutls
ADD ./etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf

####################
# PKI
RUN mkdir -p /usr/share/simplesamlphp/cert && openssl req -x509 -batch -nodes -newkey rsa:4096 -keyout /usr/share/simplesamlphp/cert/saml.pem -out /usr/share/simplesamlphp/cert/saml.crt

####################
# Composer
RUN php5enmod mcrypt

####################
# Final bits

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
