# docker image for simple NodeJS demo

# based on Ubuntu 14.04
FROM ubuntu:14.04

# update repo cache and install base dependencies
RUN apt-get update && apt-get install -y \
      curl \
      git \
      software-properties-common

# install NodeJS repo, dependencies, GPG key, and NodeJS itself
RUN curl -sL https://deb.nodesource.com/setup \
      | bash -

RUN apt-get -y install nodejs

# Checkout the hello world code branch master - 'ADD' is a cache busting work-around
# https://github.com/docker/docker/issues/1996
ADD https://beacon.nist.gov/rest/record/last /tmp/cache_buster
RUN git clone -b master git://github.com/ihashacks/hello-world-nodejs.git /hello-world-nodejs

# Command to run at "docker run ..."
CMD if [ -z $BRANCH ]; then BRANCH=master; fi; \
      cd /hello-world-nodejs \
      && git fetch origin $BRANCH \
      && git checkout $BRANCH \
      && git pull \
      && git submodule init && git submodule update \
      && nodejs hello-world.js
