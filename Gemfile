source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use postgresql as the database for Active Record
gem 'pg'
# Used for authentication
gem 'devise'
# Way better than WEBrick
gem 'thin'
# Turns out, you need this for Heroku
gem 'rails_12factor', group: :production
# Have you tried this yet? Do it
group :development do
  gem "better_errors"
  gem "binding_of_caller"
end
# Better testing
group :development, :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: false
end
# Bind that shit
gem 'pry'
# A necessary evil
gem 'ruby_meetup2'
# Ugh
gem 'omniauth'
# Double-ugh
gem 'omniauth-meetup', '~> 0.0.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'meetup_client'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development
# Powering Faye messaging
gem 'private_pub'
# Heroku needs clarity sometimes
ruby "2.1.2"
