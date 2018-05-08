FROM mediawiki

WORKDIR /var/www

RUN mkdir w && \
    mv html/* w/ && \
    mv w html/ && \
    apt-get update && \
    apt-get install -y libpng-dev wget unzip nano && \
    docker-php-ext-install gd && \
    a2enmod rewrite

WORKDIR /var/www/html/w

ADD https://getcomposer.org/installer composer-setup.php

RUN php composer-setup.php && \
    php composer.phar require --no-plugins --no-scripts --update-no-dev mediawiki/validator && \
    php composer.phar require --no-plugins --no-scripts --update-no-dev mediawiki/semantic-media-wiki && \
    php composer.phar require --no-plugins --no-scripts --update-no-dev mediawiki/maps && \
    php composer.phar require --no-plugins --no-scripts --update-no-dev mediawiki/semantic-result-formats && \
    php composer.phar require --no-plugins --no-scripts --update-no-dev mediawiki/semantic-compound-queries && \
    wget https://github.com/HydraWiki/mediawiki-embedvideo/archive/v2.7.3.zip && \
    unzip v2.7.3.zip -d extensions/ && \
    mv extensions/mediawiki-embedvideo-2.7.3/ extensions/EmbedVideo && \
    rm v2.7.3.zip && \
    rm composer*

WORKDIR /var/www/html

COPY 000-default.conf /etc/apache2/sites-available/
COPY update_wiki /usr/local/bin/
COPY LocalSettings.php w/
COPY mediawiki mediawiki

RUN chmod -R 755 mediawiki
