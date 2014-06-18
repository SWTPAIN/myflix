source 'https://rubygems.org'
ruby '2.0.0'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'bootstrap_form'
gem 'bcrypt-ruby'
gem 'fabrication'
gem 'faker'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'redis'
gem 'foreman'
gem 'paratrooper'
gem 'unicorn'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog', "~> 1.3.1"

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :test, :development do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-email', github: 'dockyard/capybara-email'
  gem 'launchy'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem "sentry-raven"
end

