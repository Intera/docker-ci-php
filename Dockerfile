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
		php7.3-apcu \
		php7.3-cli \
		php7.3-curl \
		php7.3-gd \
		php7.3-igbinary \
		php7.3-imap \
		php7.3-intl \
		php7.3-json \
		php7.3-ldap \
		php7.3-mbstring \
		php7.3-mysql \
		php7.3-pgsql \
		php7.3-soap \
		php7.3-sqlite3 \
		php7.3-xdebug \
		php7.3-phpdbg \
		php7.3-xml \
		php7.3-zip

RUN apt-get install -y \
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
		gnupg \
		parallel

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
