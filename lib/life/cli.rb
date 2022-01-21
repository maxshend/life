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

    option :width, default: nil, type: :numeric, aliases: %w[w], banner: 'Grid width'
    option :height, default: nil, type: :numeric, aliases: %w[h], banner: 'Grid height'
    desc 'start', 'Start Game of Life'
    def start
      i = 0
      grid = Grid.new(
        width: options[:width] || Grid::DEFAULT_WIDTH,
        height: options[:height] || Grid::DEFAULT_HEIGHT
      )

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
