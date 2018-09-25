#!/bin/bash
set -e

source ~/.profile
git clone https://github.com/Artemmkin/reddit.git
cd reddit
bundle install

sleep 30
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
