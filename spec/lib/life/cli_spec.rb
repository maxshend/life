# frozen_string_literal: true

RSpec.describe Life::CLI do
  let(:cli) { described_class.new }

  describe '#version' do
    it 'prints current version' do
      expect { cli.version }.to output("v#{Life::VERSION}\n").to_stdout
    end
  end
end
