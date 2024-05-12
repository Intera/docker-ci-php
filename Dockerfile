FROM ubuntu:22.04

COPY install_composer.sh /tmp/install_composer.sh

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y

RUN apt-get install -y --no-install-recommends \
		php8.2-apcu \
		php8.2-cli \
		php8.2-curl \
		php8.2-gd \
        php-imagick \
		php8.2-imap \
		php8.2-intl \
		php8.2-ldap \
		php8.2-mbstring \
		php8.2-mysql \
		php8.2-pgsql \
		php8.2-soap \
		php8.2-sqlite3 \
		php8.2-xdebug \
		php8.2-phpdbg \
		php8.2-xml \
		php8.2-zip

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

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get install -y nodejs yarn

RUN apt-get purge -y software-properties-common apt-transport-https lsb-release gnupg \
    && apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
