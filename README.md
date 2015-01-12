## Description

This is a Feed Reader Application.

## Environment

- Ruby 2.0 (2.0.0p195)
- Rails 4.0 (4.0.0)
- Nginx 1.4
- PostgreSQL 9.3 (or SQLite)

## Setting

Please install Ruby 2.0, Rails 4.0 and necessary Gem, Nginx 1.4, PostgreSQL 9.3 (or SQLite) and do necessary setting.
You must run Nginx and PostgreSQL.
Then, Please do the following.

	$ git clone https://github.com/shimizu-daisuke/readerd.git

	$ cd readerd

	$ bundle install --path vendor/bundler

	$ bundle exec rake generate_secret_token:generate

 	$ vi config/database.yml

	$ bundle exec rake db:migrate

	$ bundle exec unicorn_rails -c config/unicorn.rb -E production -D -p 3000
