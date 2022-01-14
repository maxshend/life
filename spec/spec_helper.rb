# frozen_string_literal: true

require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.start do
  add_filter 'spec/'
  add_filter './github/'
  add_filter 'lib/life/version'
end

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter if ENV['CI'] == 'true'

Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }
