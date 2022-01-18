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
      grid = Grid.new

      loop do
        clear_screen
        puts "Generation ##{i}"
        puts grid
        sleep 1
        i += 1
        grid.next_generation!
      end
    end
    default_task :start

    private

    def clear_screen
      print "\e[H\e[2J"
    end
  end
end
