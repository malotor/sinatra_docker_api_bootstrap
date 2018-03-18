#!/bin/bash
if [ "$RACK_ENV" == "production" ];
then
  #bundle install --without development test
  ruby $MAIN_APP_FILE -p 80
else
  #bundle install
  if [ "$RACK_ENV" == "test" ];
  then
    rspec
  else
    #gem install shotgun
    shotgun -p 80 config.ru
  fi
fi
