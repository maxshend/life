# frozen_string_literal: true

require 'thor'
require 'tty-box'

module Life
  class CLI < Thor
    desc 'version', 'Show current version'
    def version
      puts "v#{Life::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'start', 'Start Game of Life'
    def start
      i = 0

      loop do
        clear_screen
        puts i
        sleep 1
        i += 1
      end
    end
    default_task :start

    private

    def clear_screen
      puts "\e[H\e[2J"
    end
  end
end
