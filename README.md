# Tech Blog

Blog written in Ruby.

## Demo

- http://www.kyamada.com/

## Architecture

* language     : Ruby2
* web framework: Rails4
* database     : MongoDB
* js framework : Backbone.js
* markdown     : Redcarpet

## Installation (Mac)

~~~
$ git clone https://github.com/k-yamada/techblog.git
$ cd techblog
$ ./bin/build_mac.sh
$ bundle install
$ rails s
~~~

View at: http://localhost:3000/

## Deploy to Linux Server (Ubuntu)

* deploy check

~~~
$ bundle exec cap production deploy:check
~~~

* set environments variables

~~~
$ ssh <deploy_server>
$ vim /var/www/techblog/shared/.env

export TECHBLOG_DEPLOY_USER=<server login user>
export TECHBLOG_DEPLOY_SERVER=<server ip or domain>

$ source ~/.bashrc
~~~

* deploy with capistrano

~~~
$ bundle exec cap production deploy
~~~

* nginx conf sample

[config/nginx_sample.conf](https://github.com/k-yamada/techblog/blob/master/config/nginx_sample.conf)

## Import data from other blog service

### Import from Lokka

~~~
$ RAILS_ENV=production LOKKA_DB=/path/to/lokka.sqlite3 rake import:from_lokka
~~~
