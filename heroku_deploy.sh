#!/bin/bash -e 
app_name=my-laravel-heroku

heroku apps:create $app_name
heroku addons:create heroku-postgresql:hobby-dev --app $app_name
heroku addons:create heroku-redis:hobby-dev --app $app_name

# bisa ganti dengan repo di scm
# kyknya ini g perlu
# heroku git:remote --app $app_name

heroku config:set APP_KEY=$(php artisan --no-ansi key:generate --show) --app $app_name
heroku config:set APP_LOG=errorlog --app $app_name
heroku config:set QUEUE_DRIVER=redis SESSION_DRIVER=redis CACHE_DRIVER=redis --app $app_name
heroku config:set APP_ENV=development APP_DEBUG=true APP_LOG_LEVEL=debug --app $app_name

# setting tambahan di laravel
composer require predis/predis

# tambahakan baris code berikut di config/database.php untuk menyesuaikan denhan redis_url
# if (getenv('REDIS_URL')) {
#     $url = parse_url(getenv('REDIS_URL'));

#     putenv('REDIS_HOST='.$url['host']);
#     putenv('REDIS_PORT='.$url['port']);
#     putenv('REDIS_PASSWORD='.$url['pass']);
# }
