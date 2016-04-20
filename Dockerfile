## -*- docker-image-name: "scaleway/ruby:latest" -*-
FROM scaleway/ubuntu:amd64-trusty
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-trusty       # arch=armv7l
#FROM scaleway/ubuntu:arm64-trusty       # arch=arm64
#FROM scaleway/ubuntu:i386-trusty        # arch=i386
#FROM scaleway/ubuntu:mips-trusty        # arch=mips


# Prepare rootfs for image-builder
RUN /usr/local/sbin/scw-builder-enter


# Install packages
RUN apt-get -q update     \
 && apt-get -q -y upgrade \
 && apt-get install -y -q \
      apache2             \
      php5                \
      php5-cli            \
      php5-mcrypt         \
      php5-memcache       \
      php5-mysql          \
      php5-gd             \
      pwgen               \
 && apt-get clean


ENV PRESTASHOP_VERSION 1.6.1.5


# Patch rootfs
COPY ./overlay/ /

# Install Prestashop
RUN wget -qO prestashop.tar.gz https://github.com/PrestaShop/PrestaShop/archive/$PRESTASHOP_VERSION.tar.gz \
 && rm -rf /var/www/html/* \
 && tar -xzf prestashop.tar.gz -C /tmp/ \
 && mv /tmp/PrestaShop-$PRESTASHOP_VERSION/* /var/www/html \
 && rm -fr /tmp/PrestaShop-$PRESTASHOP_VERSION


# Change permissions
RUN chown -R www-data:www-data /var/www/html


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
