# frozen_string_literal: true

require 'life/cli'
require 'life/version'

module Life
  class << self
    def output
      @output ||= $stdout
    end
  end
end
