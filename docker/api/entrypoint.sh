#!/bin/bash

rm -f /usr/src/app/tmp/pids/server.pid

bundle check || bundle install -j8

bundle exec rails db:prepare

bundle exec puma -C config/puma.rb
