FROM ubuntu:16.04

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common python-software-properties \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y

RUN apt-get install -y \
		php7.2-apcu \
		php7.2-cli \
		php7.2-curl \
		php7.2-gd \
		php7.2-igbinary \
		php7.2-intl \
		php7.2-json \
		php7.2-ldap \
		php7.2-mbstring \
		php7.2-mcrypt \
		php7.2-mysql \
		php7.2-pgsql \
		php7.2-soap \
		php7.2-sqlite3 \
		php7.2-xdebug \
		php7.2-xml \
		php7.2-zip \
		imagemagick \
		language-pack-de \
		wget \
		git \
		openssh-client

RUN bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/

RUN apt-get purge -y software-properties-common python-software-properties \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
