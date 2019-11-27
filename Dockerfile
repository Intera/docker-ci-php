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
		php7.1-apcu \
		php7.1-cli \
		php7.1-curl \
		php7.1-gd \
		php7.1-igbinary \
		php7.1-imap \
		php7.1-intl \
		php7.1-json \
		php7.1-ldap \
		php7.1-mbstring \
		php7.1-mcrypt \
		php7.1-mysql \
		php7.1-pgsql \
		php7.1-soap \
		php7.1-sqlite3 \
		php7.1-xdebug \
		php7.1-phpdbg \
		php7.1-xml \
		php7.1-zip \
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
