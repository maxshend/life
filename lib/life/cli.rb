# frozen_string_literal: true

require 'thor'

module Life
  class CLI < Thor
    desc 'version', 'Show current version'
    def version
      require_relative 'version'
      puts "v#{Life::VERSION}"
    end
    map %w[--version -v] => :version
  end
end
