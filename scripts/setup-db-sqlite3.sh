#!/bin/bash

set -eu

sudo apt-get install -y --no-install-recommends libsqlite3-dev

cd $REDMINE_DIR
cat <<EOS > config/database.yml
  test:
    adapter: sqlite3
    database: db/test.sqlite3
EOS
