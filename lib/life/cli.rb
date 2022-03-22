# frozen_string_literal: true

require 'thor'
require 'tty-box'

module Life
  class CLI < Thor
    OUTPUT_FILE = 'life.gif'

    desc 'version', 'Show current version'
    def version
      puts "v#{Life::VERSION}"
    end
    map %w[--version -v] => :version

    option :width, default: nil, type: :numeric, aliases: %w[w], banner: 'Grid width'
    option :height, default: nil, type: :numeric, aliases: %w[h], banner: 'Grid height'
    option :input, default: nil, type: :string, aliases: %w[i], banner: 'CSV input file name'
    option :export, default: nil, type: :boolean, aliases: %w[e], banner: 'Export to a file'
    option :iterations, default: 20, type: :numeric, aliases: %w[n], banner: 'Number of iterations in the output file'
    desc 'start', 'Start Game of Life'
    def start
      check_start_options options

      i = 0
      grid = Grid.new(
        width: options[:width] || Grid::DEFAULT_WIDTH,
        height: options[:height] || Grid::DEFAULT_HEIGHT,
        filename: options[:input]
      )

      if options[:export]
        # Until https://github.com/soutaro/steep/issues/481 fixed
        # rubocop:disable Style/HashSyntax
        gif = Life::Grid::GIFGenerator.new(grid: grid, iterations: options[:iterations]).generate
        # rubocop:enable Style/HashSyntax
        gif.write OUTPUT_FILE

        return
      end

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
