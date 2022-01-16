# frozen_string_literal: true

require 'thor'
require 'tty-box'

module Life
  class CLI < Thor
    GRID_HEIGHT = 10
    GRID_WIDTH = 20

    desc 'version', 'Show current version'
    def version
      Life.output.puts "v#{Life::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'grid', 'Display grid'
    def grid
      data = Array.new(GRID_HEIGHT, "#{'*' * GRID_WIDTH}\n").join
      box = TTY::Box.frame data

      Life.output.puts box.to_s
    end
    default_task :grid
  end
end
