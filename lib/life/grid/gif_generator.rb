# frozen_string_literal: true

require 'rmagick'

module Life
  class Grid
    class GIFGenerator
      include Magick

      DEFAULT_WIDTH = 600
      DEFAULT_HEIGHT = 600
      MAX_ITERATIONS = 50
      ANIMATION_DELAY = 40

      def initialize(grid:, iterations: 1)
        raise ArgumentError, 'Invalid Grid object' unless grid.is_a? Life::Grid
        raise ArgumentError, 'Number of iterations should be positive' unless iterations.positive?

        @iterations = iterations > MAX_ITERATIONS ? MAX_ITERATIONS : iterations
        @grid = grid
        @data = grid.state

        return unless @data.size.zero? || @data[0].size.zero?

        raise ArgumentError, 'Grid should has positive number of rows and columns'
      end

      def generate
        result = ImageList.new

        @iterations.times do |i|
          result << new_image

          unless i == @iterations - 1
            @grid.next_generation!
            @data = @grid.state
          end
        end

        result
      end

      private

      def new_image
        img = Image.new DEFAULT_WIDTH, DEFAULT_HEIGHT, SolidFill.new('white')
        img.delay = ANIMATION_DELAY

        cell_w = img.columns.to_f / @data[0].size
        cell_h = img.rows.to_f / @data.size

        cells = Draw.new
        cells.stroke = 'black'
        cells.fill = 'grey'

        @data.each_with_index do |row, i|
          row.each_with_index do |column, j|
            cells.rectangle cell_w * i, cell_h * j, cell_w * (i + 1), cell_h * (j + 1) if column
          end
        end

        cells.draw img

        img
      end
    end
  end
end
