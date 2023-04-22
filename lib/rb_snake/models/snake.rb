# frozen_string_literal: true

require "rb_snake/models/direction"
require "rb_snake/models/coordinate"

module RbSnake
  module Models
    class Snake
      RenderedBodyElem = Struct.new(:elem, :position)

      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def render(window, &block)
        return build_rendered_body(&block) if rendered_body.nil?

        update_last_rendered_position(window)
        update_first_rendered_position(&block)
      end

      def next_position(direction, grid)
        new_row = head.row
        new_col = head.col

        case direction
        when Direction::UP
          new_row -= 1
        when Direction::RIGHT
          new_col += 1
        when Direction::DOWN
          new_row += 1
        when Direction::LEFT
          new_col -= 1
        else
          raise StandardError, "direction #{direction} not recognized"
        end


        new_row = 0 if new_row >= grid.rows
        new_row = grid.rows - 1 if new_row.negative?

        new_col = 0 if new_col >= grid.cols
        new_col = grid.cols - 1 if new_col.negative?

        Coordinate.new(row: new_row, col: new_col)
      end

      def eat(food)
        body.unshift(food.location)
      end

      def move_to(position)
        body.unshift(position)
        body.pop
      end

      private

      def head
        body.first
      end

      def build_rendered_body(&block)
        @rendered_body = body.map do |position|
          elem = block.call(position.row, position.col)
          RenderedBodyElem.new(elem, position)
        end
      end

      def update_last_rendered_position(window)
        return if rendered_body.last.position == body.last

        window.remove(rendered_body.last.elem)
        rendered_body.pop
      end

      def update_first_rendered_position(&block)
        return if rendered_body.first.position == body.first

        new_position = body.first
        elem = block.call(new_position.row, new_position.col)
        rendered_body.unshift(RenderedBodyElem.new(elem, new_position))
      end

      attr_reader :rendered_body
    end
  end
end
