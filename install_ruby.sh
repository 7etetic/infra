#!/bin/bash

# Install RVM
echo "Installing Ruby & RVM..."
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable

# Install dependences for RVM & Ruby

source ~/.rvm/scripts/rvm
rvm requirements

# Install Ruby 2.4.1

rvm install 2.4.1
rvm use 2.4.1 --default
gem install bundler -V --no-ri --no-rdoc
echo "Finished installation Ruby & RVM."
ruby -v && bundle -v


