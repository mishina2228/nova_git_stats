require 'English'

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_stats/version'

Gem::Specification.new do |gem|
  gem.name          = 'git_stats'
  gem.version       = GitStats::VERSION
  gem.authors       = ['Tomasz Gieniusz']
  gem.email         = ['tomasz.gieniusz@gmail.com']
  gem.description   = 'Git history statistics generator'
  gem.summary       = 'HTML statistics generator from git repository'
  gem.homepage      = 'https://github.com/mishina2228/git_stats'
  gem.licenses      = ['MIT']

  gem.files         = Dir['{config,lib,templates}/**/*']
  gem.executables   = ['git_stats']
  gem.require_paths = ['lib']

  gem.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  gem.add_dependency('actionview', '~> 6.1')
  gem.add_dependency('activesupport', '~> 6.1')
  gem.add_dependency('haml', '~> 5.0')
  gem.add_dependency('i18n', '~> 1.8')
  gem.add_dependency('lazy_high_charts', '~> 1.6')
  gem.add_dependency('thor', '~> 1.0')
  gem.add_dependency('tilt', '~> 2.0')
end
