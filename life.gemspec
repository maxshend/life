# frozen_string_literal: true

require File.expand_path('lib/life/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'life'
  s.version     = Life::VERSION
  s.summary     = "Conway's Game Of Life in Ruby"
  s.description = "Conway's Game Of Life in Ruby"
  s.authors     = ['Maksim Shendrik']
  s.email       = 'shendrik.mv@gmail.com'
  s.homepage    = 'https://github.com/maxshend/life'
  s.license     = 'MIT'

  s.files = Dir[
    'README.md',
    'LICENSE',
    'CHANGELOG.md',
    'Rakefile',
    'Gemfile',
    'lib/**/*.rb',
    'lib/**/*.rake',
    'life.gemspec'
  ]

  s.metadata = {
    'rubygems_mfa_required' => 'true'
  }

  s.rdoc_options     = ['--charset=UTF-8']
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.1.0'

  s.add_dependency 'thor', '~> 1.2'

  s.add_development_dependency 'rspec', '~> 3.10.0'
  s.add_development_dependency 'rubocop', '~> 1.23'
  s.add_development_dependency 'rubocop-performance', '~> 1.12'
  s.add_development_dependency 'rubocop-rspec', '~> 2.6'
  s.add_development_dependency 'simplecov', '~> 0.21.2'
  s.add_development_dependency 'simplecov-cobertura', '~> 2.0.0'
end
