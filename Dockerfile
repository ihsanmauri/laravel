# using this awesome prebuild image
FROM '123majumundur/php-7.1-nginx:cicd'
MAINTAINER Ihsan Riyadi <isnriyadi@gmail.com>

#install prestissimo
RUN composer global require hirak/prestissimo

# Make direc for hosting
RUN mkdir /home/app/app
WORKDIR /home/app/app

# Install dependencies
COPY composer.json composer.json
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader && rm -rf /home/app/.composer 

# Copy codebase 
COPY --chown=app:root . ./

# Finish composer 
RUN composer dump-autoload --no-scripts --no-dev --optimize

EXPOSE 8080