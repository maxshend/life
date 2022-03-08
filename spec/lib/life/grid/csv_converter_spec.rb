# frozen_string_literal: true

require 'tempfile'

RSpec.describe Life::Grid::CSVConverter do
  describe '#initialize' do
    context 'when filename is invalid' do
      it 'raises ArgumentError' do
        expect { described_class.new nil }.to raise_error ArgumentError
      end
    end

    context 'when file not found' do
      it 'raises ArgumentError' do
        expect { described_class.new 'not_found.txt' }.to raise_error ArgumentError
      end
    end

    context 'when file exists' do
      let(:csv) { Tempfile.new('csv') }

      after { csv.unlink }

      it 'does not raise an error' do
        expect { described_class.new csv.path }.not_to raise_error
      end
    end
  end

  describe '#convert' do
    let(:csv) do
      f = Tempfile.new('csv')
      f.write(<<~CSV)
        1,,1
        1,1,1
        ,,
      CSV
      f.rewind

      f
    end
    let(:data) do
      [
        [true, false, true],
        [true, true, true],
        [false, false, false]
      ]
    end
    let(:converter) { described_class.new(csv.path) }

    after { csv.unlink }

    it 'returns a valid grid' do
      expect(converter.convert).to eq data
    end
  end
end
