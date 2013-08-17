source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.0.rc2'
gem 'pg', '0.15.1' # PostgresSQL database
gem 'sass-rails', '~> 4.0.0.rc2'  # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript asset
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'therubyracer', platforms: :ruby # See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'jquery-rails', '3.0.1' # Use jquery as the JavaScript library
#gem 'turbolinks', '1.2.0' # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'jbuilder', '~> 1.2' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "bootstrap-sass", "~> 2.3.2.0" #Bootstrap
gem 'jquery-ui-rails'

#Additional Gems
gem "devise", "~> 3.0.0.rc" # Authentication
gem "grape", "0.5.0"  # API generation
gem "grape-rabl", "0.2.0" #Generating JSON Views for API using RABL templates

group :doc do
  gem 'sdoc', require: false   # bundle exec rake doc:rails generates the API under doc/api.
end

#Testing
gem "rspec-rails", '2.13.2', :group => [:test, :development]
group :test do
  gem "factory_girl_rails", '4.2.1'
  gem "capybara", '2.1.0'
  gem "guard-rspec", '3.0.2'
end


#Server-Side for uploading on Heroku
gem 'unicorn', '4.6.3' # Use unicorn as the app server
group :production do
  gem 'rails_12factor'
end
# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
 gem 'debugger', group: [:development, :test]
