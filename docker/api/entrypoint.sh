#!/bin/bash

rm -f /home/rails/app/tmp/pids/server.pid

bundle check || bundle install -j8

bundle exec rails db:prepare

if [ "$RESEED" = "true" ]; then
  echo "Re-initializing test databases"
  bundle exec rails db:reset RAILS_ENV=test

  echo "Re-initializing development database"
  bundle exec rails db:reset
else
  bundle exec rails db:exists RAILS_ENV=test
  init_test_database_status=$?

  if [ $init_test_database_status -ne 0 ]; then
    echo "Initializing test databases"
    bundle exec rails db:setup RAILS_ENV=test
  else
    echo "Test databases already exist; skipping setup"
  fi

  bundle exec rails db:exists RAILS_ENV=development
  init_development_database_status=$?

  if [ $init_development_database_status -ne 0 ]; then
    echo "Initializing development database"
    bundle exec rails db:setup
  else
    echo "Development database already exists; skipping setup"
  fi
fi

bundle exec rails db:migrate

bundle exec puma -C config/puma.rb
