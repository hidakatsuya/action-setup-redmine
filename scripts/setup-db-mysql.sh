#!/bin/bash

set -eu

sudo apt-get install -y --no-install-recommends default-mysql-client

docker run \
    --name redmine-mysql \
    -e MYSQL_ROOT_PASSWORD=password \
    -e MYSQL_DATABASE=redmine_test \
    -p 3306:3306 \
    -d $DATABASE \
    --character-set-server=utf8mb4 \
    --collation-server=utf8mb4_unicode_ci

cd $REDMINE_DIR
cat <<EOS > config/database.yml
  test:
    adapter: mysql2
    database: redmine_test
    host: 127.0.0.1
    port: 3306
    username: root
    password: password
    encoding: utf8mb4
EOS
