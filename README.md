# Splunka

System sales analysis via log file (.txt)


## Overview

This system works with upload a log sales file (sales batch) and generate a total revenue  about this batch.

> Warn: This is not a real system. It is just one example of use Ruby on Rails.

## How to deploy in production

> This project is not done to using in production.

## How to build in Development Environment

This guide go to help you build this project in development environment.
We recommend you use one ruby version manager as [rbenv](http://rbenv.org/) | [rvm](https://rvm.io/).

- 1. Clone this project on Github with `git clone https://github.com/paulopatto/Splunka.git`
- 2. In home path this project you should download all dependencies with bundler `bundle install`
- 3. After run bundler you should you database config, one example file is in config/database.yml.sample, maybe you want use it with `cp config/database.yml.sample config/database.yml`.
- 4. After configured database you go run `bundle exec rake db:migrate` to generate ou database schema.
- 5. This project manage frontend dependencies with [bower](https://bower.io/), to build dependencies use `bower install`

To run tests you user `bundle exec rspec spec`, to run webserver use `bundle exec rails server`,
you server should listen in http://localhost:3000/

### Requirements

- Ruby 2.1.3
- Rails 4.2.7
- SQLite 3 (in ubuntu run `sudo apt-get install -y sqlite3 libsqlite3-dev`)
- Gem Bundler (`gem install bundler`)
- NodeJS
- Bower (`npm install bower -g`)


