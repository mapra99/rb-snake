# frozen_string_literal: true

module RbSnake
  module Actions
    class MoveSnake
      class << self
        def call(state)
          snake = state.snake
          current_direction = state.current_direction
          food = state.food
          grid = state.grid

          next_position = snake.next_position(current_direction)
          if next_position.eql?(food.location)
            snake.eat(food)
            food.regenerate(snake, grid)
          else
            snake.move_to(next_position)
          end
        end
      end
    end
  end
end
