# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Core
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.1'

# Tools
gem 'alba', '~> 2.1'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt', '~> 2.6'
gem 'oj', '~> 3.13', '>= 3.13.23'

# System
gem 'bootsnap', '~> 1.15', require: false
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

group :development, :test do
  gem 'brakeman', '~> 5.4', require: false
  gem 'rubocop', '~> 1.43', require: false
  gem 'rubocop-rails', '~> 2.17', '>= 2.17.4', require: false
  gem 'rubocop-rspec', '~> 2.18', require: false

  gem 'pry-rails', '~> 0.3.9'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0', '>= 2.0.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.1'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'shoulda-matchers', '~> 5.3'
  gem 'test-prof', '~> 1.1'
  gem 'timecop', '~> 0.9.6'
end
