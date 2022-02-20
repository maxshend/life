# frozen_string_literal: true

require 'stringio'

module Life
  class Grid
    DEFAULT_WIDTH = 25
    DEFAULT_HEIGHT = 25

    attr_reader :width, :height, :state

    def initialize(width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT, state: nil, filename: nil)
      if filename
        converter = CSVConverter.new(filename)
        @state = converter.convert
        @width = @state[0].size
        @height = @state.size

        return
      end

      raise ArgumentError, 'Grid width and height should be positive' unless width.positive? && height.positive?

      if state
        @width = state[0].size
        @height = state.size
        @state = state
      else
        @width = width
        @height = height
        @state = Array.new(height) { Array.new(width) { rand < 0.5 } }
      end
    end

    def next_generation!
      new_state = Array.new(height) { Array.new(width, false) }

      height.times do |row|
        width.times do |column|
          new_state[row][column] = alive?(row, column)
        end
      end

      @state = new_state
    end

    def to_s
      result = StringIO.new

      @state.each do |row|
        row.each_with_index do |column, i|
          result << (column ? ' *' : '  ')
          result << "\n" if i == row.size - 1
        end
      end

      result.string
    end

    private

    def neighbors_count(row, column)
      count = 0
      if column.positive?
        count += 1 if row.positive? && @state[row - 1][column - 1]
        count += 1 if row < height - 1 && @state[row + 1][column - 1]
        count += 1 if @state[row][column - 1]
      end
      if row.positive?
        count += 1 if @state[row - 1][column]
        count += 1 if column < width - 1 && @state[row - 1][column + 1]
      end
      if column < width - 1
        count += 1 if @state[row][column + 1]
        count += 1 if row < height - 1 && @state[row + 1][column + 1]
      end
      count += 1 if row < height - 1 && @state[row + 1][column]

      count
    end

    def alive?(row, column)
      neighbors = neighbors_count(row, column)

      neighbors == 3 || (@state[row][column] && neighbors == 2)
    end
  end
end
