# Tech Blog

Blog written in Ruby.

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

* set environments

~~~
$ vim ~/.bashrc

export TECHBLOG_DEPLOY_USER=<server login user>
export TECHBLOG_DEPLOY_SERVER=<server ip or domain>

$ source ~/.bashrc
~~~

* deploy with capistrano

~~~
$ bundle exec cap production deploy
// restart
$ bundle exec cap production deploy:restart
~~~

* nginx conf sample

~~~
config/nginx_sample.conf
~~~

## Import data from other blog service

### Import from Lokka

~~~
$ RAILS_ENV=production LOKKA_DB=/path/to/lokka.sqlite3 rake import:from_lokka
~~~
