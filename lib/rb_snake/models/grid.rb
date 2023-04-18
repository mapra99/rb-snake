# frozen_string_literal: true

module RbSnake
  module Models
    class Grid
      attr_reader :rows, :cols

      def initialize(rows:, cols:)
        @rows = rows
        @cols = cols
      end
    end
  end
end
