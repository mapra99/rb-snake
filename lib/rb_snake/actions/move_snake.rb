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

          next_position = snake.next_position(current_direction, grid)
          if next_position.eql?(food.location)
            snake.eat(food)
            food.regenerate(snake, grid)
          elsif snake.body.any? { |body_pos| body_pos.eql?(next_position) }
            state.finish_game!
          else
            snake.move_to(next_position)
          end

          window.render(state)
        end
      end
    end
  end
end
