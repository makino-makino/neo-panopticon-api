#bundle update
#bundle install

rm ./tmp/pids/server.pid
#export $(cat .env | grep -v ^# | xargs);

#rails db:create
#rails db:migrate RAILS_ENV=development
#heroku pg:reset neo-panopticon

bundle exec rails s -p $PORT -b '0.0.0.0'

