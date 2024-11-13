#!/bin/bash

set -eu

# v5.1.3.stable -> 5.1.stable
major_version_with_branch=$REDMINE_VERSION_MAJOR.$REDMINE_VERSION_MINOR.$REDMINE_VERSION_BRANCH

case $major_version_with_branch in
    6.0.devel)
        setup_version="next";;
    6.0*|5.1*|5.0*)
        setup_version="$REDMINE_VERSION_MAJOR.$REDMINE_VERSION_MINOR";;
    *)
        setup_version="next";;
esac

echo "Running scripts/setup-base-$setup_version.sh for Redmine $REDMINE_VERSION ..."

./scripts/setup-base-$setup_version.sh
