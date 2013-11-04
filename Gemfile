source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Asset stuff
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'   # JS compressor
gem 'therubyracer'

gem 'twilio-ruby'

# Parsing and verifying phone numbers
gem 'global_phone'
gem 'global_phone_dbgen'

gem 'newrelic_rpm'

# Group specific gems
group :test do
  gem 'factory_girl_rails'
  gem 'turn', '~> 0.9.0'
end

group :development do
  gem 'thin'
  gem 'quiet_assets'
  gem 'debugger'
  gem 'capistrano', '2.15.5'
end

group :production do
  gem 'unicorn'
  gem 'mysql2'
  gem 'activerecord-mysql-adapter'
end
