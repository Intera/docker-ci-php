FROM ubuntu:18.04

COPY install_composer.sh /tmp/install_composer.sh

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y

RUN apt-get install -y \
		php7.2-apcu \
		php7.2-cli \
		php7.2-curl \
		php7.2-gd \
		php7.2-igbinary \
		php7.2-imap \
		php7.2-intl \
		php7.2-json \
		php7.2-ldap \
		php7.2-mbstring \
		php7.2-mysql \
		php7.2-pgsql \
		php7.2-soap \
		php7.2-sqlite3 \
		php7.2-xdebug \
		php7.2-phpdbg \
		php7.2-xml \
		php7.2-zip \
		imagemagick \
		language-pack-de \
		wget \
		git \
		unzip \
		openssh-client \
		mysql-client \
		rsync \
		curl \
		apt-transport-https \
		lsb-release \
		gnupg


RUN bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get install -y nodejs yarn

RUN apt-get purge -y apt-transport-https lsb-release gnupg \
    && apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
