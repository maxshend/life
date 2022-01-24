# frozen_string_literal: true

require 'csv'

module Life
  class Grid
    class CSVConverter
      def initialize(filename)
        raise ArgumentError, "File '#{filename}' not found" unless filename && File.file?(filename)

        @filename = filename
        @data = nil
      end

      def convert
        return @data if @data

        height = 0
        width = 0

        CSV.foreach(@filename, 'r', col_sep: ',') do |row|
          width = row.size if row.size > width
          height += 1
        end

        @data = Array.new(height) { Array.new(width, false) }

        CSV.foreach(@filename, 'r', col_sep: ',').each_with_index do |row, i|
          row.each_with_index do |cell, j|
            @data[i][j] = !cell.nil? && !cell.strip.empty?
          end
        end

        @data
      end
    end
  end
end
