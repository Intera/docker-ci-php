FROM ubuntu:18.04

COPY install_composer.sh /tmp/install_composer.sh

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y

RUN apt-get install -y \
		php7.4-apcu \
		php7.4-cli \
		php7.4-curl \
		php7.4-gd \
		php7.4-imap \
		php7.4-intl \
		php7.4-json \
		php7.4-ldap \
		php7.4-mbstring \
		php7.4-mysql \
		php7.4-pgsql \
		php7.4-soap \
		php7.4-sqlite3 \
		php7.4-xdebug \
		php7.4-phpdbg \
		php7.4-xml \
		php7.4-zip \
		imagemagick \
		language-pack-de \
		wget \
		git \
		unzip \
		openssh-client \
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

RUN apt-get purge -y software-properties-common apt-transport-https lsb-release gnupg \
    && apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
