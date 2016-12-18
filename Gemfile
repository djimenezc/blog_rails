source 'http://rubygems.org'
ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.7.1'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise'
gem 'pundit'
gem 'upmin-admin'
gem 'simple_form'

gem 'bootstrap-sass'

gem 'paperclip', '~> 4.2'
gem 'fog'
# gem 'aws-sdk', '~> 1.5.7'

gem 'wysiwyg-rails'
gem 'font-awesome-rails'

# Use ActiveModel has_secure_password
gem 'bcrypt'

gem 'log4r'

gem 'nokogiri'
gem 'mechanize'
# gem 'screencap', '0.1.4'
gem 'gastly', '1.0.1'
gem 'graphicsmagick'
# gem 'fastimage'

# gem 'execjs'
# gem 'therubyracer', :platforms => :ruby

gem 'redcarpet', '~> 3.1.2'

gem 'mongoid', '~> 5.1.0'
gem 'kaminari-mongoid'
gem 'mail'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test, :development_postgres do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'database_cleaner', '~> 1.5.1'

  gem 'turn', :require => false
  gem 'shoulda'
  gem 'rspec-rails'
  gem 'simplecov', '0.8.2', :require => false
  gem 'simplecov-rcov', '0.2.3'
  # gem 'nokogiri'
  gem 'factory_girl_rails', '4.5.0'

  gem 'brakeman', '2.6.2', :require => false
  gem 'annotate', '2.6.5'

  gem 'rake'
  gem 'travis'

  # gem 'guard'
  # gem 'guard-livereload', require: false
  # gem 'rack-livereload'


  gem 'rest-client'

  gem 'meta_request'

end

group :development_postgres, :production do
  gem 'pg'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', :require => 'sqlite3'
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn', '4.8.3'
  gem 'newrelic_rpm'
end
