#!/bin/sh

# default setup
sudo apt-get -y update
sudo apt-get install -y wget ntp
sudo cp -f project/provision/ntp.conf /etc/ntp.conf
sudo service ntp restart

# postgres install
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo cp -f project/provision/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
echo "CREATE USER ubuntu; ALTER USER ubuntu PASSWORD 'ubuntu';" | sudo -u postgres psql
echo "CREATE DATABASE mydb; GRANT ALL PRIVILEGES ON DATABASE mydb TO ubuntu;" | sudo -u postgres psql
sudo -u postgres pg_ctlcluster 9.5 main reload

# nginx setup
sudo apt-get -y install nginx
sudo service nginx start
sudo cp project/provision/nginx.conf /etc/nginx/sites-available/default
sudo service nginx restart

# rails setup (sqlite3 libsqlite3-dev)
sudo apt-get install -y ruby-dev sqlite3 libsqlite3-dev zlib1g-dev nodejs build-essential
gem install bundler --conservative 

# followings are page specific setup
cd /home/ubuntu/project
bundle install

# unicorn setup
chmod +x provision/unicorn_rails
sudo cp -f provision/unicorn_rails /etc/init.d/unicorn_rails
sudo update-rc.d unicorn_rails defaults

# bundle install --binstubs
sudo service unicorn_rails restart

rake assets:precompile RAILS_ENV=production
rake db:migrate RAILS_ENV=production

