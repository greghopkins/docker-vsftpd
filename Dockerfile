# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.18

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

# https://github.com/phusion/baseimage-docker#upgrading-the-operating-system-inside-the-container
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# install vsftpd
RUN apt-get install -y --no-install-recommends vsftpd 

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
