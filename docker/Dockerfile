# docker image for simple NodeJS demo

# based on Ubuntu 14.04
FROM ubuntu:14.04

# update repo cache
RUN apt-get update

# install base dependencies
RUN apt-get -y install software-properties-common
RUN apt-get -y install curl
RUN apt-get -y install git

# install NodeJS repo, dependencies, GPG key, and NodeJS itself
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get -y install nodejs

# Checkout the hello world code branch master
RUN git clone -b master git://github.com/ihashacks/hello-world-nodejs.git /hello-world-nodejs

# Command to run at "docker run ..."
CMD if [ -z $BRANCH ]; then BRANCH=master; fi; \
  cd /hello-world-nodejs \
  && git checkout $BRANCH \
  && git pull \
  && git submodule init && git submodule update \
  && nodejs hello-world.js
