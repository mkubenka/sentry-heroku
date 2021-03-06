Sentry on Heroku
================

    Sentry_ is a realtime event logging and aggregation platform.  At its core
    it specializes in monitoring errors and extracting all the information
    needed to do a proper post-mortem without any of the hassle of the
    standard user feedback loop.

    .. _Sentry: https://github.com/getsentry/sentry


Basic setup
-----------

Follow the steps below to get Sentry up and running on Heroku:

1. Create a new Heroku application. Replace "APP_NAME" with your
   application's name::

        heroku apps:create --region eu APP_NAME

2. Add database to the application::

        heroku addons:add heroku-postgresql:dev
        heroku pg:promote $(heroku config -s | awk -F= '$1 ~ /^HEROKU_POSTGRESQL_[A-Z]+_URL$/ {print $1}')

3. Set Sentry's shared secret for global administration privileges::

        heroku config:set SENTRY_KEY=$(python -c "import base64, os; print(base64.b64encode(os.urandom(40)).decode())")

4. Set the absolute URL to the Sentry root directory. The URL should not include
   a trailing slash. Replace the URL below with your application's URL::

        heroku config:set SENTRY_URL_PREFIX=https://sentry.example.com

5. Deploy Sentry to Heroku::

        git push heroku master

6. Run Sentry's database migrations::

        heroku run "sentry --config=sentry.conf.py upgrade"

7. Create a user account for yourself::

        heroku run "sentry --config=sentry.conf.py createsuperuser"

That's it!


Email notifications
-------------------

Follow the steps below, if you want to enable Sentry's email notifications:

1. Add SendGrid add-on to your Heroku application (verified Heroku account is needed)::

        heroku addons:add sendgrid

2. Set the reply-to email address for outgoing mail::

        heroku config:set SERVER_EMAIL=sentry@example.com

3. Set the email addresses that should be notified::

        heroku config:set ADMINS=john.matrix@example.com,jack.daniels@example.com

If you want to use your own SMTP server change ``EMAIL_*`` variables in ``sentry.conf.py``.