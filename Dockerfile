FROM php:7.4-cli

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    git vim unzip cron \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install gd
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl

RUN docker-php-ext-install -j$(nproc) opcache bcmath pdo_mysql soap xsl zip sockets

# Install Xdebug (but don't enable)
RUN pecl install -o xdebug

# Install nvm, node, grunt
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && . ~/.bashrc \
    && nvm install 12 \
    && npm i -g grunt-cli

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer


RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

ADD ./php-custom.ini $PHP_INI_DIR/conf.d/
# Custom entrypoint to start cron service
ADD custom-entrypoint.sh /usr/local/bin/

# Add virmrc
ADD .vimrc /root/.vimrc
# Add some alias
ADD .bash_aliases /usr/local/share/.bash_aliases

ENTRYPOINT [ "/usr/local/bin/custom-entrypoint.sh" ]

