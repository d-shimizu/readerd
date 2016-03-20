## Description

This is a Feed Reader Application.

## Environment

- Ruby 2.1 (2.1.8p440)
- Rails 4.2 (4.2.6)
- PostgreSQL 9.3 (or SQLite)

## Setting

Please install Ruby 2.1, Rails 4.2 and necessary Gem, PostgreSQL 9.3 (or SQLite) and do necessary setting.
If you install PostgreSQL then you must run PostgreSQL.
Then, Please do the following.

	$ git clone https://github.com/shimizu-daisuke/readerd.git

	$ cd readerd

	$ bundle install --path vendor/bundle

 	$ vi config/database.yml

        $ bundle exec rake db:setup

	$ bundle exec rake db:migrate

	$ bundle exec rake generate_secret_token:generate

	$ bundle exec rake assets:precompile

        $ bundle exec rails s -b 0.0.0.0
        or
	$ bundle exec unicorn_rails -c config/unicorn.rb -E production -D -p 3000
