# frozen_string_literal: true

module RbSnake
  module Actions
    class MoveSnake
      class << self
        def call(state, window)
          snake = state.snake
          current_direction = state.current_direction
          food = state.food
          grid = state.grid

          make_next_move(snake, current_direction, food, grid, state)

          window.render(state)
        end

        private

        def make_next_move(snake, current_direction, food, grid, state)
          next_position = snake.next_position(current_direction, grid)
          if next_position.eql?(food.location)
            snake.eat(food)
            food.regenerate(snake, grid)
            state.increase_speed if (snake.body.length % 10).zero?
          elsif snake.body.any? { |body_pos| body_pos.eql?(next_position) }
            state.finish_game!
          else
            snake.move_to(next_position)
          end
        end
      end
    end
  end
end
