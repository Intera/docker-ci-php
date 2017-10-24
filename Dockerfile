FROM ubuntu:16.04

COPY install_composer.sh /tmp/install_composer.sh

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y software-properties-common python-software-properties \
	&& export LANG=C.UTF-8 \
	&& add-apt-repository ppa:ondrej/php \
	&& apt-get update -y \
	&& apt-get install -y \
		php5.6-cli \
		php5.6-curl \
		php5.6-gd \
		php5.6-igbinary \
		php5.6-intl \
		php5.6-json \
		php5.6-mbstring \
		php5.6-mcrypt \
		php5.6-mysql \
		php5.6-pgsql \
		php5.6-soap \
		php5.6-sqlite3 \
		php5.6-xdebug \
		php5.6-xml \
		php5.6-zip \
		imagemagick \
		language-pack-de \
		wget \
		git \
	&& bash /tmp/install_composer.sh \
	&& mv composer.phar /usr/local/bin/ \
	&& apt-get purge -y software-properties-common python-software-properties \
	&& apt-get --purge -y autoremove \
	&& apt-get autoclean \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
