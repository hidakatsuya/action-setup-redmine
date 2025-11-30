#!/bin/bash

set -eu

file=$REDMINE_DIR/lib/redmine/version.rb

version_major=$(grep -oE 'MAJOR *= *[0-9]+' $file | awk 'NR==1 {print $3}')
version_minor=$(grep -oE 'MINOR *= *[0-9]+' $file | awk 'NR==1 {print $3}')
version_tiny=$(grep -oE 'TINY *= *[0-9]+' $file | awk 'NR==1 {print $3}')
version_branch=$(grep -oE 'BRANCH *= *'\''.+?' $file | awk -F"'" 'NR==1 {print $2}')

redmine_version=$version_major.$version_minor.$version_tiny.$version_branch
redmine_major_version_number=$version_major$(printf "%02d" $version_minor)

# v5.1.3.stable -> 5.1.3.stable
echo "REDMINE_VERSION=$redmine_version" >> $GITHUB_ENV

# v5.1.3.stable -> 5
echo "REDMINE_VERSION_MAJOR=$version_major" >> $GITHUB_ENV
# v5.1.3.stable -> 1
echo "REDMINE_VERSION_MINOR=$version_minor" >> $GITHUB_ENV
# v5.1.3.stable -> 3
echo "REDMINE_VERSION_TINY=$version_tiny" >> $GITHUB_ENV
# v5.1.3.stable -> stable
echo "REDMINE_VERSION_BRANCH=$version_branch" >> $GITHUB_ENV

# v5.1.3.stable -> 501
echo "REDMINE_MAJOR_VERSION_NUMBER=$redmine_major_version_number" >> $GITHUB_ENV

# Output version information
echo "Redmine Version: $redmine_version"
echo "Redmine Major Version Number: $redmine_major_version_number"
