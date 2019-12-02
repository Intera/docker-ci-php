FROM ubuntu:16.04

COPY install_composer.sh /tmp/install_composer.sh

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common python-software-properties \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y

RUN apt-get install -y \
		php5.6-apc \
		php5.6-cli \
		php5.6-curl \
		php5.6-gd \
		php5.6-igbinary \
		php5.6-imap \
		php5.6-intl \
		php5.6-json \
		php5.6-ldap \
		php5.6-mbstring \
		php5.6-mcrypt \
		php5.6-mysql \
		php5.6-pgsql \
		php5.6-soap \
		php5.6-sqlite3 \
		php5.6-xdebug \
		php5.6-phpdbg \
		php5.6-xml \
		php5.6-zip \
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

RUN apt-get purge -y software-properties-common python-software-properties lsb-release \
    && apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
