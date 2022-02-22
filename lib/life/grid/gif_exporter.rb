# frozen_string_literal: true

require 'rmagick'

module Life
  class Grid
    class GIFExporter
      include Magick

      DEFAULT_WIDTH = 800
      DEFAULT_HEIGHT = 600

      def initialize(grid)
        raise ArgumentError, 'Invalid Grid object' unless grid.is_a? Life::Grid

        @data = grid.state

        return unless @data.size.zero? || @data[0].size.zero?

        raise ArgumentError, 'Grid should has positive number of rows and columns'
      end

      def export
        img = Image.new DEFAULT_WIDTH, DEFAULT_HEIGHT, SolidFill.new('white')
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
