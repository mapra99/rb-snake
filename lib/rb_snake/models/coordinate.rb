# frozen_string_literal: true

module RbSnake
  module Models
    class Coordinate
      attr_accessor :row, :col

      def initialize(row:, col:)
        @row = row
        @col = col
      end
    end
  end
end
