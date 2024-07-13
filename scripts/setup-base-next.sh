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

# Set up Google Chrome for system tests
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install -y --no-install-recommends google-chrome-stable
echo GOOGLE_CHROME_OPTS_ARGS="headless,disable-gpu,no-sandbox,disable-dev-shm-usage" >> $GITHUB_ENV
