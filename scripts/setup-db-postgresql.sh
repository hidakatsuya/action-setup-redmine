#!/bin/bash

set -eu

sudo apt-get install -y --no-install-recommends libpq-dev

docker run \
    --name redmine-postgres \
    -e POSTGRES_PASSWORD=postgres \
    -p 5432:5432 \
    -d $DATABASE

cd $REDMINE_DIR
cat <<EOS > config/database.yml
  test:
    adapter: postgresql
    database: redmine_test
    encoding: utf8
    host: localhost
    port: 5432
    username: postgres
    password: postgres
EOS
