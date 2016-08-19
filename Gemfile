source 'https://rubygems.org'
ruby "2.3.0"

gem 'rails', '4.2.7'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'font-awesome-sass', '~> 4.6.2'

# Use Puma as default server
gem 'puma'

gem 'compass-rails'
# https://github.com/Compass/compass/pull/2088
git 'https://github.com/ably-forks/compass', branch: 'sass-deprecation-warning-fix' do
  gem 'compass-core'
end

# Spree E-commerce
gem 'spree', '~> 3.1.0'
gem 'spree_auth_devise', '~> 3.1.0'
gem 'spree_gateway', '~> 3.1.0'
gem 'spree_multi_domain', github: 'spree-contrib/spree-multi-domain', branch: '3-1-stable'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

group :production do
  # User Rack Timeout to tell Puma when to timeout requests
  gem "rack-timeout"

  gem 'pg'
  gem 'rails_12factor'
end

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
