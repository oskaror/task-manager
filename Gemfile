# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Core
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.1'

# Tools
gem 'bcrypt', '~> 3.1.7'

# System
gem 'bootsnap', '~> 1.15', require: false
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

group :development, :test do
  gem 'rubocop', '~> 1.43', require: false
  gem 'rubocop-rails', '~> 2.17', '>= 2.17.4', require: false
  gem 'rubocop-rspec', '~> 2.18', require: false
end
