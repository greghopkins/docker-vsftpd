# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.18
MAINTAINER Gregory D. Hopkins <greg.hopkins@gmail.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# https://github.com/phusion/baseimage-docker#upgrading-the-operating-system-inside-the-container
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# install vsftpd
RUN apt-get install -y --no-install-recommends vsftpd

# Clean up APT when done.
# TODO does this go at the end of the file?
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY vsftpd.conf /etc

RUN mkdir /etc/service/vsftpd
ADD vsftpd.sh /etc/service/vsftpd/run

RUN mkdir -p /var/run/vsftpd/empty
RUN mkdir -p /var/ftp/public
RUN chown ftp:ftp /var/ftp/public

EXPOSE 20 21
