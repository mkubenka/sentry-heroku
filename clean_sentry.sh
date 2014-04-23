#!/bin/bash

# If table is locked move to paid version, cleanup and move back:
# https://devcenter.heroku.com/articles/upgrade-heroku-postgres-with-pgbackups

heroku run sentry --config=sentry.conf.py cleanup --days=14
