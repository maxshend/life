# frozen_string_literal: true

require 'simplecov'

unless ENV['SKIP_COV']
  SimpleCov.start do
    add_filter 'spec/'
    add_filter '.github/'
    add_filter 'lib/life/version'
  end

  if ENV['CI'] == 'true'
    require 'simplecov-cobertura'
    SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
  end
end

require 'life'

Dir["#{__dir__}/support/**/*.rb"].each { |f| require f }
