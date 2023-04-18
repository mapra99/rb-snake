# frozen_string_literal: true

module RbSnake
  module Models
    class Snake
      attr_reader :body

      def initialize(body:)
        @body = body
      end
    end
  end
end
