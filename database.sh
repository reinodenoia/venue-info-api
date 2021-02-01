#!/bin/bash
set -e

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

exec "$@"