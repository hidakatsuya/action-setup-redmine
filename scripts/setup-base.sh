#!/bin/bash

set -eu

# v7.0.1.stable -> 7.0.stable
major_version_with_branch=$REDMINE_VERSION_MAJOR.$REDMINE_VERSION_MINOR.$REDMINE_VERSION_BRANCH

case $major_version_with_branch in
    7.0.devel)
        setup_version="next";;
    7.0*|6.1*|6.0*)
        setup_version="$REDMINE_VERSION_MAJOR.$REDMINE_VERSION_MINOR";;
    *)
        setup_version="next";;
esac

echo "Running scripts/setup-base-$setup_version.sh for Redmine $REDMINE_VERSION ..."

$GITHUB_ACTION_PATH/scripts/setup-base-$setup_version.sh
