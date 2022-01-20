# frozen_string_literal: true

require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-performance'
  task.requires << 'rubocop-rspec'
  task.requires << 'rubocop-rake'
end

desc 'check for type errors'
task :steep do
  require 'steep'
  require 'steep/cli'

  Steep::CLI.new(argv: ['check'], stdout: $stdout, stderr: $stderr, stdin: $stdin).run
end

task default: %w[steep rubocop spec]
