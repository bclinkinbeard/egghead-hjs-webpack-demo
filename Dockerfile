#
# Docker container for the node sender
#
# node:argon does not install node inspector properly with install -g
# fails on a v8 package, use glen's insteadj
#FROM glenschler/nodejs-inspector:4
# To run on rpi
# FROM resin/rpi-node:argon
FROM node:argon
#FROM glenschler/nodejs-inspector:4
MAINTAINER Rich Tong (rich@surround.io)
ENV DEBIAN_FRONTEND=noninteractive
EXPOSE 3000
# node inspector debugging port
EXPOSE 5858 8080

# Need vim for debugging
# https://spin.atomicobject.com/2015/09/25/debug-node-js/
RUN apt-get update -y && \
    apt-get install -y \
        vim

# Yeoman has does not want to be run as root and will fail
# It sets itself to UID 501 arbitrarily if it detects root
# https://github.com/yeoman/yeoman.github.io/issues/282
# https://github.com/krakenjs/generator-kraken/issues/114#issuecomment-54201366
# So you must run this in a different user context
# generated with npm init and then npm installs
# http://stackoverflow.com/questions/27701930/add-user-to-docker-container
# And this creates a new problem since yo tries to create global modules
# without sudo access so we need to open up permissions enough so that a 
# non-sudo user can add things properly in node and also to create the yo
# command
RUN chmod 777 /usr/local/lib/node_modules /usr/local/bin
RUN useradd -ms /bin/bash node 
USER node
WORKDIR /home/node

# Need .babelrc so babel knows what languages to compile
COPY package.json webpack.config.js ./
# Note if you just do COPY src ./ then it will copy all contents of src into the
# top 
COPY src src/

RUN npm install

# Using jhs-webpack so need to call it from there
# If you want to debug then run `make debug` and this command will not be run
CMD npm start
