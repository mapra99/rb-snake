# frozen_string_literal: true

require "rb_snake/models/coordinate"
require "rb_snake/models/snake"
require "rb_snake/models/food"
require "rb_snake/models/grid"
require "rb_snake/models/direction"

module RbSnake
  module Models
    class State
      attr_reader :snake, :food, :grid, :current_direction, :game_finished

      def initialize(snake:, food:, grid:, current_direction:, game_finished:)
        @snake = snake
        @food = food
        @grid = grid
        @current_direction = current_direction
        @game_finished = game_finished
      end

      def self.initial_state
        new(
          snake: Snake.new(
            body: [Coordinate.new(row: 1, col: 1), Coordinate.new(row: 0, col: 1)]
          ),
          food: Food.new(row: 4, col: 4),
          grid: Grid.new(rows: 8, cols: 12),
          current_direction: Direction::DOWN,
          game_finished: false
        )
      end
    end
  end
end
