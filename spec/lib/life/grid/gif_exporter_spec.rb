# frozen_string_literal: true

require 'rmagick'

RSpec.describe Life::Grid::GIFExporter do
  describe '#initializer' do
    describe 'with valid grid' do
      let(:grid) { Life::Grid.new }

      it 'does not raise an error' do
        expect { described_class.new(grid) }.not_to raise_error
      end
    end

    describe 'with invalid grid' do
      describe 'when grid object is invalid' do
        it 'raises ArgumentError' do
          expect { described_class.new(Object.new) }.to raise_error ArgumentError
        end
      end

      describe 'when grid is empty' do
        let(:grid) { Life::Grid.new width: 0, height: 1 }

        it 'raises ArgumentError' do
          expect { described_class.new(grid) }.to raise_error ArgumentError
        end
      end
    end
  end

  describe '#export' do
    let(:grid) { Life::Grid.new width: 10, height: 10 }
    let(:exporter) { described_class.new grid }
    let(:img) { exporter.export }

    it 'returns RMagick image' do
      expect(img).to be_a Magick::Image
    end

    it 'returns an image with valid dimensions' do
      expect([img.rows, img.columns]).to eq(
        [Life::Grid::GIFExporter::DEFAULT_HEIGHT, Life::Grid::GIFExporter::DEFAULT_WIDTH]
      )
    end
  end
end
