FROM ubuntu:16.04

COPY install_composer.sh /tmp/install_composer.sh

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y

RUN apt-get install -y \
		php-apcu \
		php7.0-cli \
		php7.0-curl \
		php7.0-gd \
		php-igbinary \
		php7.0-imap \
		php7.0-intl \
		php7.0-json \
		php7.0-ldap \
		php7.0-mbstring \
		php7.0-mcrypt \
		php7.0-mysql \
		php7.0-pgsql \
		php7.0-soap \
		php7.0-sqlite3 \
		php-xdebug \
		php7.0-phpdbg \
		php7.0-xml \
		php7.0-zip

RUN apt-get install -y \
		imagemagick \
		language-pack-de \
		wget \
		git \
		zip \
		unzip \
		openssh-client \
		mysql-client \
		rsync \
		curl \
		apt-transport-https \
		lsb-release \
		gnupg \
		parallel

RUN bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

RUN apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
