# frozen_string_literal: true

require_relative 'lib/git_stats/version'

Gem::Specification.new do |s|
  s.name          = 'nova_git_stats'
  s.version       = GitStats::VERSION
  s.authors       = ['Tomasz Gieniusz', 'mishina2228']
  s.email         = %w(tomasz.gieniusz@gmail.com temma182008+github@gmail.com)
  s.description   = 'Git history statistics generator'
  s.summary       = 'HTML statistics generator from git repository'
  s.homepage      = 'https://github.com/mishina2228/nova_git_stats'
  s.license       = 'MIT'

  s.metadata = {
    'bug_tracker_uri' => "#{s.homepage}/issues",
    'changelog_uri' => "#{s.homepage}/blob/master/CHANGELOG.md",
    'homepage_uri' => s.homepage,
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => "#{s.homepage}/tree/v#{s.version}"
  }

  s.files         = Dir['{config,lib,templates}/**/*', 'CHANGELOG.md', 'LICENSE.txt', 'README.md']
  s.executables   = ['git_stats']
  s.require_paths = ['lib']

  s.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  s.add_dependency('actionview', '>= 5.2', '< 8.0')
  s.add_dependency('activesupport', '>= 5.2', '< 8.0')
  s.add_dependency('haml', '>= 5', '< 7')
  s.add_dependency('i18n', '~> 1.8')
  s.add_dependency('lazy_high_charts', '~> 1.6')
  s.add_dependency('thor', '~> 1.0')
  s.add_dependency('tilt', '~> 2.0')
end
