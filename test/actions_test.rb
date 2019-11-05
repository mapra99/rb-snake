# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/actions/actions'
require_relative '../src/model/state'
require 'byebug'

class ActionsTest < Minitest::Test
  def setup
    @initial_state = Model::State.new(
      Model::Snake.new([Model::Coord.new(1, 1),
                        Model::Coord.new(0, 1)]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
  end

  def test_move_snake
    expected_state = Model::State.new(
      Model::Snake.new([Model::Coord.new(2, 1),
                        Model::Coord.new(1, 1)]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    actual_state = Actions::move_snake(@initial_state)
    assert_equal actual_state, expected_state
  end

  def test_invalid_change_direction
    expected_state = Model::State.new(
      Model::Snake.new([Model::Coord.new(1, 1),
                        Model::Coord.new(0, 1)]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    actual_state = Actions::change_direction(@initial_state, Model::Direction::UP)
    assert_equal actual_state, expected_state
  end

  def test_valid_change_direction
    expected_state = Model::State.new(
      Model::Snake.new([Model::Coord.new(1, 1),
                        Model::Coord.new(0, 1)]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::LEFT,
      false
    )
    actual_state = Actions::change_direction(@initial_state, Model::Direction::LEFT)
    assert_equal actual_state, expected_state
  end

  def test_snake_grow
    @initial_state.food = Model::Food.new(2,1)

    expected_state = Model::Snake.new([Model::Coord.new(2, 1),
                                       Model::Coord.new(1, 1),
                                       Model::Coord.new(0, 1)])
    actual_state = Actions::change_direction(@initial_state, Model::Direction::LEFT)
    assert_equal actual_state.snake, expected_state
  end
end
