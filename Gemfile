# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'factory_bot', '~> 6.4', '!= 6.4.5'
gem 'rake', '~> 13.0'
gem 'rspec', '~> 3.10'
gem 'simplecov', '~> 0.21'
gem 'simplecov-cobertura', '~> 3.0'

# Crashes with a combination of Rails 7.0 or earlier and concurrent-ruby 1.3.5+.
# https://github.com/rails/rails/issues/54260
gem 'concurrent-ruby', '< 1.3.5' if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.7.0')

case active_support_version = ENV.fetch('ACTIVE_SUPPORT_VERSION', 'latest')
when 'latest'
  gem 'actionview'
  gem 'activesupport'
else
  gem 'actionview', active_support_version
  gem 'activesupport', active_support_version
end

if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.7')
  group :lint do
    gem 'haml_lint', '~> 0.37'
    gem 'rubocop', '~> 1.8'
    gem 'rubocop-factory_bot', '~> 2.26'
    gem 'rubocop-performance', '~> 1.9'
    gem 'rubocop-rake', '~> 0.5'
    gem 'rubocop-rspec', '~> 3.2'
  end
end
