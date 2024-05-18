# Setup Redmine

[![Build](https://github.com/hidakatsuya/action-setup-redmine/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/hidakatsuya/action-setup-redmine/actions/workflows/build.yml)

This action installs Redmine and sets up an environment to run tests. It is primarily aimed at providing an environment to run tests for Redmine plugins.

## Usage

```yaml
- uses: hidakatsuya/action-setup-redmine@v1
  with:
    # Redmine repository to setup. Default is redmine/redmine.
    repository: 'redmine/redmine'

    # The branch, tag or commit to checkout. Default is master.
    version: 'master'

    # Database to use for testing. Possible values are sqlite3 or
    # PostgreSQL and MySQL Docker official image tags (e.g. postgres:14, mysql:8.4.0). Default is sqlite3
    database: 'sqlite3'

    # Ruby version to use for testing. See ruby/setup-ruby's ruby-version input for available versions.
    ruby-version: ''

    # Directory to setup Redmine. Default is the current directory.
    path: '.'
```

See also [action.yml](./action.yml).

## Example

### Setting up [RedMica](https://github.com/redmica/redmica)

```yaml
- uses: hidakatsuya/action-setup-redmine@v1
  with:
    repository: 'redmica/redmica'
    version: 'v2.4.2'
    database: 'postgres:14'
    ruby-version: '3.2'
```

### Run a test for the Redmine plugin

For example, you are developing the `redmine_hello_world` plugin on GitHub repository. To run a test for that plugin in GitHub Action, do the following:

```yaml
- uses: hidakatsuya/action-setup-redmine@v1
  with:
    ruby-version: '3.3'

- uses: action/checkout@v4
  with:
    path: plugins/redmine_hello_world

- run: |
    bundle install
    bin/rails redmine:plugins:test NAME=redmine_hello_world
```

## Versioning

This action follows [the recommendations of GitHub Actions Versioning](https://github.com/actions/toolkit/blob/master/docs/action-versioning.md).

## Releasing

1. Make sure CI for main branch has passed
2. Create a new release to publish to the GitHub Marketplace
3. Make sure that the release workflow has passed
