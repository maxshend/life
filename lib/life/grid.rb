# frozen_string_literal: true

require 'stringio'

module Life
  class Grid
    attr_reader :width, :height, :state

    def initialize(width: 25, height: 25, state: nil)
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

      height.times do |y|
        width.times do |x|
          new_state[x][y] = alive?(x, y)
        end
      end

      @state = new_state
    end

    def to_s
      result = StringIO.new

      @state.each do |row|
        row.each_with_index do |cell, i|
          result << (cell ? ' *' : '  ')
          result << "\n" if i == row.size - 1
        end
      end

      result.string
    end

    private

    def neighbors_count(x, y)
      return nil unless in_range?(x, y)

      count = 0
      count += 1 if x.positive? && y.positive? && @state[x - 1][y - 1]
      count += 1 if y.positive? && @state[x][y - 1]
      count += 1 if x < width - 1 && y.positive? && @state[x + 1][y - 1]
      count += 1 if x < width - 1 && @state[x + 1][y]
      count += 1 if x < width - 1 && y < height - 1 && @state[x + 1][y + 1]
      count += 1 if y < height - 1 && @state[x][y + 1]
      count += 1 if x.positive? && y < height - 1 && @state[x - 1][y + 1]
      count += 1 if x.positive? && @state[x - 1][y]

      count
    end

    def alive?(x, y)
      neighbors = neighbors_count(x, y)

      (@state[x][y] && [2, 3].include?(neighbors)) || (!@state[x][y] && neighbors == 3)
    end

    def in_range?(x, y)
      (x >= 0 && x < width) && (y >= 0 && y < height)
    end
  end
end
