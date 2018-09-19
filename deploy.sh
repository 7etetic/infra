#!/bin/bash

# Deploy  Reddit & Puma
echo "Installing Reddit and deploying Puma..."
git clone https://github.com/Artemmkin/reddit.git
cd reddit && bundle install
sudo -u appuser puma -d
echo "Installation finished"
ps -aux | grep puma

