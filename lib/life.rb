# frozen_string_literal: true

require_relative 'life/cli'
require_relative 'life/version'

module Life
  class << self
    def output
      @output ||= $stdout
    end
  end
end
