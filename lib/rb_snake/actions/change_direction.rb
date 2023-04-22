# frozen_string_literal: true

require "rb_snake/models/direction"

module RbSnake
  module Actions
    class ChangeDirection
      class << self
        def call(state, new_direction:)
          return unless valid_direction?(state.current_direction, new_direction)

          state.update_direction(new_direction)
        end

        private

        def valid_direction?(current_direction, new_direction)
          case current_direction
          when RbSnake::Models::Direction::UP
            !new_direction.eql?(RbSnake::Models::Direction::DOWN)
          when RbSnake::Models::Direction::DOWN
            !new_direction.eql?(RbSnake::Models::Direction::UP)
          when RbSnake::Models::Direction::LEFT
            !new_direction.eql?(RbSnake::Models::Direction::RIGHT)
          when RbSnake::Models::Direction::RIGHT
            !new_direction.eql?(RbSnake::Models::Direction::LEFT)
          end
        end
      end
    end
  end
end
