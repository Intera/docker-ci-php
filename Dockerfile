FROM ubuntu:16.04

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common python-software-properties \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y \
	&& apt-get install -y \
		php7.1-apcu \
		php7.1-cli \
		php7.1-curl \
		php7.1-gd \
		php7.1-igbinary \
		php7.1-intl \
		php7.1-json \
		php7.1-mbstring \
		php7.1-mcrypt \
		php7.1-mysql \
		php7.1-pgsql \
		php7.1-soap \
		php7.1-sqlite3 \
		php7.1-xdebug \
		php7.1-xml \
		php7.1-zip \
		imagemagick \
		language-pack-de \
		wget \
		git \
		openssh-client \
	&& bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/ \
	&& apt-get purge -y software-properties-common python-software-properties \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
