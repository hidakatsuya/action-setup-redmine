#!/bin/bash

set -eu

file=$REDMINE_DIR/lib/redmine/version.rb

version_major=$(grep -oE 'MAJOR *= *[0-9]+' $file | awk 'NR==1 {print $3}')
version_minor=$(grep -oE 'MINOR *= *[0-9]+' $file | awk 'NR==1 {print $3}')
version_tiny=$(grep -oE 'TINY *= *[0-9]+' $file | awk 'NR==1 {print $3}')
version_branch=$(grep -oE 'BRANCH *= *'\''.+?' $file | awk -F"'" 'NR==1 {print $2}')

echo "Redmine Version: $version_major.$version_minor.$version_tiny.$version_branch"

echo "REDMINE_VERSION_MAJOR=$version_major" >> $GITHUB_ENV
echo "REDMINE_VERSION_MINOR=$version_minor" >> $GITHUB_ENV
echo "REDMINE_VERSION_TINY=$version_tiny" >> $GITHUB_ENV
echo "REDMINE_VERSION_BRANCH=$version_branch" >> $GITHUB_ENV
