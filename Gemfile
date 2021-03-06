# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'dotenv'
gem 'dotenv-rails'

gem 'active_model_serializers'
gem 'carrierwave'
gem 'cocoon'
gem 'devise'
gem 'doorkeeper'
gem 'gon'
gem 'mysql2', '~> 0.3.18'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'pundit'
gem 'remotipart'
gem 'responders'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: false
gem 'skim'
gem 'slim-rails'
gem 'thinking-sphinx', '~> 3.2.0'
gem 'twitter-bootstrap-rails'
gem 'whenever', require: false
gem 'with_model'
gem 'unicorn'

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'json_spec'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capybara-email'
  gem 'letter_opener'
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano3-unicorn', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
