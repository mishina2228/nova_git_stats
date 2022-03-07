require_relative 'lib/git_stats/version'

Gem::Specification.new do |gem|
  gem.name          = 'nova_git_stats'
  gem.version       = GitStats::VERSION
  gem.authors       = ['Tomasz Gieniusz', 'mishina2228']
  gem.email         = %w(tomasz.gieniusz@gmail.com temma182008+github@gmail.com)
  gem.description   = 'Git history statistics generator'
  gem.summary       = 'HTML statistics generator from git repository'
  gem.homepage      = 'https://github.com/mishina2228/git_stats'
  gem.license       = 'MIT'

  gem.metadata = {
    'rubygems_mfa_required' => 'true'
  }

  gem.files         = Dir['{config,lib,templates}/**/*']
  gem.executables   = ['git_stats']
  gem.require_paths = ['lib']

  gem.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  gem.add_dependency('actionview', '>= 6.1', '< 8.0')
  gem.add_dependency('activesupport', '>= 6.1', '< 8.0')
  gem.add_dependency('haml', '~> 5.0')
  gem.add_dependency('i18n', '~> 1.8')
  gem.add_dependency('lazy_high_charts', '~> 1.6')
  gem.add_dependency('thor', '~> 1.0')
  gem.add_dependency('tilt', '~> 2.0')
end
