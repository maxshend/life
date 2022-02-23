# frozen_string_literal: true

require 'rmagick'

RSpec.describe Life::Grid::GIFGenerator do
  describe '#initializer' do
    describe 'with valid grid' do
      let(:grid) { Life::Grid.new }

      it 'does not raise an error' do
        expect { described_class.new(grid:) }.not_to raise_error
      end
    end

    describe 'with invalid grid' do
      describe 'when grid object is invalid' do
        it 'raises ArgumentError' do
          expect { described_class.new(grid: Object.new) }.to raise_error ArgumentError
        end
      end

      describe 'when grid is empty' do
        let(:grid) { Life::Grid.new width: 0, height: 1 }

        it 'raises ArgumentError' do
          expect { described_class.new(grid:) }.to raise_error ArgumentError
        end
      end
    end
  end

  describe '#generate' do
    let(:grid) { Life::Grid.new width: 10, height: 10 }
    let(:generator) { described_class.new grid:, iterations: 2 }
    let(:img) { generator.generate }

    it 'returns RMagick images' do
      expect(img.all?(Magick::Image)).to be true
    end

    it 'returns valid number of images' do
      expect(img.size).to eq 2
    end

    it 'returns images with valid dimensions' do
      expect([img.rows, img.columns]).to eq(
        [Life::Grid::GIFGenerator::DEFAULT_HEIGHT, Life::Grid::GIFGenerator::DEFAULT_WIDTH]
      )
    end
  end
end
