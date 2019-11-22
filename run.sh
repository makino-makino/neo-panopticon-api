bundle update
bundle install

rails db:create
rails db:migrate RAILS_ENV=development

bundle exec rails s -p 3000 -b '0.0.0.0'

