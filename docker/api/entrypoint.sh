#!/bin/bash

rm -f /home/rails/app/tmp/pids/server.pid

bundle check || bundle install -j8

bundle exec rails db:prepare

if [ "$RESEED" = "true" ]; then
  echo "Re-initializing development database"
  bundle exec rails db:reset

  echo "Re-initializing test databases"
  bundle exec rails db:reset RAILS_ENV=test
else
  init_test_database=$(psql -lqt "$DATABASE_URL" | cut -d \| -f 1 | grep -w api_test)
  init_development_database=$(psql -lqt "$DATABASE_URL" | cut -d \| -f 1 | grep -w api_development)

  if test -z "$init_test_database"; then
    echo "Initializing test databases"
    bundle exec rails db:setup RAILS_ENV=test
  else
    echo "Test databases already exist; skipping setup"
  fi

  if test -z "$init_development_database"; then
    echo "Initializing development database"
    bundle exec rails db:setup
  else
    echo "Development database already exists; skipping setup"
  fi
fi

bundle exec puma -C config/puma.rb
