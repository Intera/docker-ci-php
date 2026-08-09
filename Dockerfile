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
		php8.3-apcu \
		php8.3-cli \
		php8.3-curl \
		php8.3-gd \
		php8.3-imap \
        php8.3-imagick \
		php8.3-intl \
		php8.3-ldap \
		php8.3-mbstring \
		php8.3-mysql \
		php8.3-pgsql \
		php8.3-soap \
		php8.3-sqlite3 \
		php8.3-xdebug \
		php8.3-phpdbg \
		php8.3-xml \
		php8.3-zip

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
    && curl -sL https://deb.nodesource.com/setup_20.x | bash -

RUN apt-get install -y nodejs yarn

RUN apt-get purge -y software-properties-common apt-transport-https lsb-release gnupg \
    && apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
