# frozen_string_literal: true

RSpec.describe Life::Grid do
  let(:data) do
    [
      [true, false],
      [false, true]
    ]
  end

  describe '#to_s' do
    describe 'with custom data' do
      let(:grid) { described_class.new(data:) }

      it 'has valid grid representation' do
        expect(grid.to_s).to eq " *  \n   *\n"
      end
    end

    describe 'with random data' do
      let(:width) { 2 }
      let(:height) { 3 }
      let(:grid) { described_class.new(width:, height:) }

      it 'has valid grid representation' do
        expect(grid.to_s).to match %r{\A([\s*]{#{width * 2}}\n){#{height}}\z}
      end
    end
  end
end
