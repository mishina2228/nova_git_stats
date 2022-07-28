# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'factory_bot', '~> 6.0'
gem 'haml_lint', '~> 0.37'
gem 'rake', '~> 13.0'
gem 'rspec', '~> 3.10'
gem 'rubocop', '~> 1.8'
gem 'rubocop-performance', '~> 1.9'
gem 'rubocop-rake', '~> 0.5'
gem 'rubocop-rspec', '~> 2.1'
gem 'simplecov', '~> 0.21'
gem 'simplecov-cobertura', '~> 2.0'

case active_support_version = ENV.fetch('ACTIVE_SUPPORT_VERSION', 'master')
when 'master'
  gem 'actionview'
  gem 'activesupport'
else
  gem 'actionview', active_support_version
  gem 'activesupport', active_support_version
end
