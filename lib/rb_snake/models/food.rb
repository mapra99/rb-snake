# frozen_string_literal: true

require "rb_snake/models/coordinate"

module RbSnake
  module Models
    class Food
      attr_reader :location

      def initialize(row:, col:)
        @location = Coordinate.new(row: row, col: col)
      end

      def render(window)
        window.remove(rendered_element) if rendered_element
        @rendered_element = yield(location.row, location.col)
      end

      def regenerate(snake, grid)
        loop do
          new_row = rand(0...grid.rows)
          new_col = rand(0...grid.cols)

          if snake.body.none? { |position| position.row == new_row && position.col == new_col }
            @location = Coordinate.new(row: new_row, col: new_col)
            break
          end
        end
      end

      private

      attr_reader :rendered_element
    end
  end
end
