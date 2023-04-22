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
          food: Food.new(row: 10, col: 1),
          grid: Grid.new(rows: 12, cols: 24),
          current_direction: Direction::DOWN,
          game_finished: false
        )
      end

      def finish_game!
        @game_finished = true
      end

      def game_score
        snake.body.length
      end

      def update_direction(new_direction)
        @current_direction = new_direction
      end
    end
  end
end
