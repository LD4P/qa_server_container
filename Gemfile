source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# rubocop:disable Bundler/OrderedGems
## Gems adds by `rails new`
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.8'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4.4'
# Use Puma as the app server
gem 'puma', '>= 5.6.4', '~>6.4.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.16', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] ### OVERRIDE - defined below to expand availability
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.9'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

## Gems manually added to for qa and qa_server engines
# Required gems for QA and linked data access
# NOTE: We need to update the published RubyGems version of qa_server with the 8.0 release. Until
# then, the next entry is set to use the GitHub repo and tag instead.
gem 'qa_server', git: 'https://github.com/LD4P/qa_server.git', tag: 'v8.0'
gem 'qa', '~> 5.10'
gem 'linkeddata'
gem 'psych', '~> 5.1'

## Gems added for application customization
# support for .env file
gem 'dotenv-rails'

# Database
gem 'mysql2'
# gem 'pg'

# additional app dependencies based on our specific setup
gem 'swagger-docs'
gem 'lograge'

group :development, :integration, :test do
  gem 'byebug' # debugging
  # gem 'database_cleaner'
end

group :development, :integration do
  # gem 'xray-rails' # overlay showing which files are contributing to the UI
  # This gem doesn't work with Ruby 3.x unless a special branch is used (see
  # https://github.com/brentd/xray-rails/pull/108). There is a PR to merge the fix
  # into the master branch, but the gem's authors don't seem to be in a hurry to
  # finish the work.
  gem "xray-rails", git: "https://github.com/brentd/xray-rails.git", branch: "bugs/ruby-3.0.0"
end

group :development do
  gem 'better_errors' # add command line in browser when errors
  gem 'binding_of_caller' # deeper stack trace used by better errors
  gem 'bixby', '~> 5.0' # style guide enforcement with rubocop
  gem 'rubocop-checkstyle_formatter', require: false
end

group :test do
  gem 'capybara-screenshot', '~> 1.0'
  gem 'coveralls', require: false
  gem 'factory_bot', '~> 4.4'
  gem 'factory_bot_rails', '~> 4.4', require: false
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks', '~> 1.0'
  gem 'rspec-its', '~> 1.1'
  gem 'rspec-rails', '~> 3.1'
  gem 'rspec_junit_formatter'
  gem 'webdrivers', '~> 4.4'
  gem 'webmock'
end
