FROM ubuntu:16.04

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y php-cli \
		php-mcrypt \
		php-soap \
		php-json \
		php-mysql \
		php-sqlite3 \
		php-zip \
		php-pgsql \
		php-gd \
		php-xml \
		php-curl \
		php-xdebug \
		php-mbstring \
		php-apcu \
		php-intl \
		imagemagick \
		language-pack-de \
		wget \
		git \

	&& chmod +x /tmp/install_composer.sh \
	&& /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/ \

	&& apt-get --purge autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
