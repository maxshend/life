# frozen_string_literal: true

RSpec.describe Life::CLI do
  subject { described_class.new }

  it 'returns valid grid' do
    expect(Life.output).to receive(:puts).with /\*+/
    subject.grid
  end
end
