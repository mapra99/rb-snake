# frozen_string_literal: true

require "rb_snake/models/coordinate"

module RbSnake
  module Models
    class Food
      attr_reader :location

      RenderedElement = Struct.new(:elem, :location)

      def initialize(row:, col:)
        @location = Coordinate.new(row: row, col: col)
      end

      def render(window)
        return if rendered_element&.location == location

        window.remove(rendered_element.elem) if rendered_element

        elem = yield(location.row, location.col)
        @rendered_element = RenderedElement.new(elem, location)
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
