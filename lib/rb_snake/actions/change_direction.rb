# frozen_string_literal: true

module RbSnake
  module Actions
    class ChangeDirection
      class << self
        def call(state, new_direction:)
          state.update_direction(new_direction)
        end
      end
    end
  end
end
