#!/bin/sh

rm /home/app/tmp/pids/server.pid || true

rake db:create
rake db:migrate              || { echo "Can't migrate database"; exit 1; }
rake db:seed                 || { echo "Can't seed database"; exit 1; }
rake tmp:clear               || { echo "Can't clear cache"; }

rm -f /tmp/service.pid || true

exec bundle exec puma -C config/puma.rb
