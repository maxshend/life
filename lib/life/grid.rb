# frozen_string_literal: true

require 'stringio'

module Life
  class Grid
    attr_reader :width, :height

    def initialize(width: 25, height: 25, data: nil)
      if data
        @width = data[0].size
        @height = data.size
        @data = data
      else
        @width = width
        @height = height
        @data = Array.new(height) { Array.new(width) { rand < 0.5 } }
      end
    end

    def to_s
      result = StringIO.new

      @data.each do |row|
        row.each_with_index do |cell, i|
          result << (cell ? ' *' : '  ')
          result << "\n" if i == row.size - 1
        end
      end

      result.string
    end
  end
end
