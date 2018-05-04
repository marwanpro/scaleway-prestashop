ARG SCW_ARCH
FROM scaleway/ubuntu:${SCW_ARCH}-xenial


# Prepare rootfs for image-builder
RUN /usr/local/sbin/scw-builder-enter


# Install packages
RUN apt-get -q update       \
 && apt-get install -y -q   \
      apache2               \
      php                  \
      php-cli              \
      php-mcrypt         \
      php-mysql          \
      php-memcache       \
      php-zip           \
      php-xml            \
      php-curl           \
      php-intl           \
      php-gd             \
      libapache2-mod-php \
      pwgen                 \
      unzip               \
 && apt-get clean


ENV PRESTASHOP_VERSION 1.7.3.2

RUN a2enmod rewrite

# Patch rootfs
COPY ./overlay/ /

# Install Prestashop
RUN wget -qO prestashop.zip https://download.prestashop.com/download/releases/prestashop_$PRESTASHOP_VERSION.zip \ 
 && rm -rf /var/www/html/* \
 && unzip prestashop.zip -d /var/www/html/

# Change permissions
RUN chown -R www-data:www-data /var/www/html


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
