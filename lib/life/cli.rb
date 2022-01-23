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
      check_start_options options

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
    rescue ArgumentError => e
      raise ::Thor::Error, e
    end
    default_task :start

    def self.exit_on_failure?
      true
    end

    private

    def clear_screen
      print "\e[H\e[2J"
    end

    def check_start_options(options)
      return unless options[:width]&.>=(100) || options[:height]&.>=(100)

      raise ::Thor::Error, 'Grid width and height must be less than 100'
    end
  end
end
