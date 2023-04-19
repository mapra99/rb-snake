# frozen_string_literal: true

require "rb_snake/models/direction"
require "rb_snake/models/coordinate"

module RbSnake
  module Models
    class Snake
      attr_reader :body

      def initialize(body:)
        @body = body
      end

      def render(window)
        rendered_body.each { |elem| window.remove(elem) } if rendered_body&.length&.positive?

        @rendered_body = body.map do |position|
          yield(position.row, position.col)
        end
      end

      def next_position(direction)
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

      attr_reader :rendered_body
    end
  end
end
