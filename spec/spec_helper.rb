# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
end
if ENV['CI']
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

require 'git_stats'

require 'factory_bot'
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.order = :random
end
