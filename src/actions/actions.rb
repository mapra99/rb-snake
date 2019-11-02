module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)
    # verificar que la siguiente casilla sea valida
    if position_is_valid?(state)
      move_snake_to state, next_position
    else
      end_game(state)
    end
    # si no es valida -> terminar el juego
    # si es valida -> movemos la serpiente
  end

  private

  def calc_next_position(state)
    case state.next_direction
    when UP
      Model::Coord.new(curr_position.row-1,
            curr_position.col)
    when RIGHT
    when DOWN
    when LEFT
    end
  end
end