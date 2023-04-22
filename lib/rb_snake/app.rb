# frozen_string_literal: true

require "rb_snake/models/state"
require "rb_snake/views/window"

module RbSnake
  class App
    attr_reader :state, :window

    def initialize
      @state = Models::State.initial_state
    end

    def start
      @window = Views::Window.new
      window.start(state)
    end
  end
end
