# frozen_string_literal: true

require "rb_snake/models/state"
require "rb_snake/views/window"

# require_relative "view/ruby2d"
# require_relative "model/state"
# require_relative "actions/actions"

module RbSnake
  class App
    attr_reader :state, :window

    def initialize
      @state = Models::State.initial_state
    end

    def start
      @window = Views::Window.new(self)

      window.start(state)
    end

    # def send_action(action, params)
    #   new_state = Actions.send(action, @state, params)
    #   return unless new_state.hash != @state

    #   @state = new_state
    #   @view.render(@state)
    # end

    private

    # def init_timer(view)
    #   loop do
    #     if @state.game_finished
    #       puts "Juego Finalizado"
    #       puts "Puntaje: #{@state.snake.positions.length}"
    #       break
    #     end
    #     @state = Actions.move_snake(@state)
    #     view.render(@state)
    #     sleep 0.1
    #   end
    # end
  end
end
