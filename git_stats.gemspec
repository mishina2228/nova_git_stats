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

  gem.files         = Dir['{bin,config,lib,templates}/**/*']
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  gem.add_dependency('actionview', '~> 6.1')
  gem.add_dependency('activesupport', '~> 6.1')
  gem.add_dependency('haml', '~> 5.0')
  gem.add_dependency('i18n', '~> 1.8')
  gem.add_dependency('lazy_high_charts', '~> 1.6')
  gem.add_dependency('thor', '~> 1.0')
  gem.add_dependency('tilt', '~> 2.0')

  gem.add_development_dependency('factory_bot', '~> 6.0')
  gem.add_development_dependency('haml_lint', '~> 0.37')
  gem.add_development_dependency('rake', '~> 13.0')
  gem.add_development_dependency('rspec', '~> 3.10')
  gem.add_development_dependency('rubocop', '~> 1.8')
  gem.add_development_dependency('rubocop-performance', '~> 1.9')
  gem.add_development_dependency('rubocop-rake', '~> 0.5')
  gem.add_development_dependency('rubocop-rspec', '~> 2.1')
  gem.add_development_dependency('simplecov', '~> 0.21')
  gem.add_development_dependency('simplecov-cobertura', '~> 1.4')
end
