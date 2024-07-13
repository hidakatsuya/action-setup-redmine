#!/bin/bash

set -eu

# Install dependencies
sudo apt-get update; \
sudo apt-get install -y --no-install-recommends \
  build-essential \
  bzr git mercurial subversion cvs \
  ghostscript \
  gsfonts \
  imagemagick libmagick++-dev \
  libnss3-dev;

# Allow ImageMagick to read PDF files
sudo sed -ri 's/(rights)="none" (pattern="PDF")/\1="read" \2/' /etc/ImageMagick-6/policy.xml

# Fix LoadError cannot load such file -- builder
# https://www.redmine.org/issues/40802
echo "gem 'builder', '~> 3.2.4'" >> $REDMINE_DIR/Gemfile.local

# Set up Google Chrome for system tests
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y --no-install-recommends google-chrome-stable
echo GOOGLE_CHROME_OPTS_ARGS="headless,disable-gpu,no-sandbox,disable-dev-shm-usage" >> $GITHUB_ENV

sed -i -e '/gem "selenium-webdriver"/d' $REDMINE_DIR/Gemfile
sed -i -e "/gem 'webdrivers'/d" $REDMINE_DIR/Gemfile
echo "gem 'selenium-webdriver', '~> 4.8.6'" >> $REDMINE_DIR/Gemfile
echo "gem 'webdrivers', '~> 5.2', require: false" >> $REDMINE_DIR/Gemfile
sed -i -e 's/desired_capabilities/capabilities/' $REDMINE_DIR/test/application_system_test_case.rb

cat $REDMINE_DIR/test/application_system_test_case.rb
cat $REDMINE_DIR/Gemfile
