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

namespace :steep do
  require 'steep'
  require 'steep/cli'

  desc 'check for type errors'
  task :check do
    Steep::CLI.new(argv: ['check'], stdout: $stdout, stderr: $stderr, stdin: $stdin).run
  end

  desc 'runtime type testing'
  task :run do
    system "SKIP_COV=true RBS_TEST_TARGET='Life::*' RUBYOPT='-rrbs/test/setup' bundle exec rspec spec"
  end
end

task default: %w[rubocop spec]
task steep: %w[steep:check steep:run]
