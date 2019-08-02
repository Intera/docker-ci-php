FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common python-software-properties \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y

RUN apt-get install -y \
		php7.3-apcu \
		php7.3-cli \
		php7.3-curl \
		php7.3-gd \
		php7.3-igbinary \
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
		php7.3-zip \
		imagemagick \
		language-pack-de \
		wget \
		git \
		unzip \
		openssh-client

RUN bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/

RUN apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

RUN apt-get purge -y software-properties-common python-software-properties \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Disable xdebug by default to improve build performance!
RUN phpdismod xdebug
