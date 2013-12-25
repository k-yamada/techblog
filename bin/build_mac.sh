#!/bin/sh
run() {
  "$@"
  result=$?
  if [ $result -ne 0 ]
  then
    echo "Failed: $@ [$PWD]" >&2
    #exit $resul
    exit 1
  fi
  return 0
}

## Install Homebrew
## ---------------
if [ -z `which brew` ]; then
  echo '--install homebrew--'
  #ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
  brew update
fi

if [ -z `which ruby-build` ]; then
  brew install readline
  brew install ruby-build
fi

if [ -z `which rbenv` ]; then
  brew install rbenv
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  source ~/.bash_profile
fi

# Install mongodb
# ---------------
if [ -z `which mongo` ]; then
  echo '--install mongodb--'
  brew install mongodb
  # To have launchd start mongodb at login:
  ln -sfv /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents
  # Then to load mongodb now:
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
  #Or, if you don't want/need launchctl, you can just run:
  #mongod
fi

# Install ruby
# ---------------
if [ -z `rbenv versions --bare | grep 2.0.0-p247` ]; then
  rbenv install 2.0.0-p247
  rbenv rehash
  rbenv global 2.0.0-p247
  RBENV_VERSION=2.0.0-p247 gem install bundler
  RBENV_VERSION=2.0.0-p247 gem install shellutils
fi
