# frozen_string_literal: true

require "rb_snake/models/coordinate"

module RbSnake
  module Models
    class Food
      attr_reader :location

      def initialize(row:, col:)
        @location = Coordinate.new(row: row, col: col)
      end
    end
  end
end
