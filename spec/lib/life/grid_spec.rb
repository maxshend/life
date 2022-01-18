# frozen_string_literal: true

RSpec.describe Life::Grid do
  describe '#to_s' do
    let(:state) do
      [
        [true, false],
        [false, true]
      ]
    end

    describe 'with custom state' do
      let(:grid) { described_class.new(state:) }

      it 'has valid grid representation' do
        expect(grid.to_s).to eq " *  \n   *\n"
      end
    end

    describe 'with random state' do
      let(:width) { 2 }
      let(:height) { 3 }
      let(:grid) { described_class.new(width:, height:) }

      it 'has valid grid representation' do
        expect(grid.to_s).to match %r{\A([\s*]{#{width * 2}}\n){#{height}}\z}
      end
    end
  end

  describe '#next_generation!' do
    let(:grid) { described_class.new(state:) }

    context "when initial state is 'blinker'" do
      let(:state) do
        [
          [false, true, false],
          [false, true, false],
          [false, true, false]
        ]
      end

      let(:next_generation) do
        [
          [false, false, false],
          [true, true, true],
          [false, false, false]
        ]
      end

      it 'changes state to the next generation' do
        expect { grid.next_generation! }.to change(grid, :state).from(state).to next_generation
      end
    end

    context "when initial state is 'block'" do
      let(:state) do
        [
          [true, true, false],
          [true, true, false],
          [false, false, false]
        ]
      end

      it 'does not change state' do
        expect { grid.next_generation! }.not_to change(grid, :state).from(state)
      end
    end

    context "when initial state is 'point'" do
      let(:state) do
        [
          [false, false, false],
          [false, true, false],
          [false, false, false]
        ]
      end

      let(:next_generation) do
        [
          [false, false, false],
          [false, false, false],
          [false, false, false]
        ]
      end

      it 'changes state to the next generation' do
        expect { grid.next_generation! }.to change(grid, :state).from(state).to next_generation
      end
    end
  end
end
