FROM ruby:3.4.2

RUN apt-get update
RUN apt-get install -y postgresql-client

RUN useradd rails --create-home --shell /bin/bash
USER rails:rails

WORKDIR /home/rails/app
