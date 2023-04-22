# frozen_string_literal: true

require "ruby2d"
require "rb_snake/models/direction"
require "rb_snake/actions/move_snake"
require "rb_snake/actions/change_direction"

module RbSnake
  module Views
    class Window
      attr_reader :app

      PIXEL_SIZE = 50

      def initialize(app)
        @app = app
        @ruby2d_window = Ruby2D::Window.new
      end

      def start(state)
        setup_window(state.grid)
        add_key_listener(state)
        render_on_each_frame(state)

        ruby2d_window.show
      end

      def render(state)
        state.food.render(ruby2d_window) do |row, col|
          render_square(row: row, col: col, color: "yellow")
        end

        state.snake.render(ruby2d_window) do |row, col|
          render_square(row: row, col: col, color: "green")
        end
      end

      private

      attr_reader :ruby2d_window

      def setup_window(grid)
        ruby2d_window.set(
          title: "Snake",
          width: PIXEL_SIZE * grid.cols,
          height: PIXEL_SIZE * grid.rows
        )
      end

      def add_key_listener(state)
        ruby2d_window.on :key_down do |event|
          handle_key_event(event, state)
        end
      end

      def render_on_each_frame(state)
        tick = 0

        ruby2d_window.update do
          Actions::MoveSnake.call(state, self) if (tick % state.speed_factor).zero?

          if state.game_finished
            ruby2d_window.close

            puts "Game Over"
            puts "Score: #{state.game_score}"
          end

          tick += 1
        end
      end

      def render_square(row:, col:, color:)
        square = Ruby2D::Square.new(
          x: col * PIXEL_SIZE,
          y: row * PIXEL_SIZE,
          size: PIXEL_SIZE,
          color: color
        )

        ruby2d_window.add(square)
        square
      end

      def handle_key_event(event, state)
        case event.key
        when "up"
          Actions::ChangeDirection.call(state, new_direction: Models::Direction::UP)
        when "down"
          Actions::ChangeDirection.call(state, new_direction: Models::Direction::DOWN)
        when "left"
          Actions::ChangeDirection.call(state, new_direction: Models::Direction::LEFT)
        when "right"
          Actions::ChangeDirection.call(state, new_direction: Models::Direction::RIGHT)
        end
      end
    end
  end
end