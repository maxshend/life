# frozen_string_literal: true

RSpec.describe Life::CLI do
  subject { described_class.new }

  it 'returns current version' do
    expect(Life.output).to receive(:puts).with "v#{Life::VERSION}"
    subject.version
  end
end
