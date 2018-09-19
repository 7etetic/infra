#!/bin/bash

# Install Ruby & dependences
echo "Installing Ruby ..."
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
echo "Finished installation Ruby"
ruby -v && bundle -v


