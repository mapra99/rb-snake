# frozen_string_literal: true

require "spec_helper"
require "rb_snake/actions/move_snake"
require "rb_snake/models/state"
require "rb_snake/models/snake"
require "rb_snake/models/coordinate"
require "rb_snake/models/food"
require "rb_snake/models/grid"
require "rb_snake/models/direction"
require "rb_snake/views/window"

RSpec.describe RbSnake::Actions::MoveSnake do
  describe ".call" do
    let(:state) do
      RbSnake::Models::State.new(
        snake: snake,
        food: food,
        grid: grid,
        current_direction: current_direction,
        game_finished: game_finished,
        speed_factor: speed_factor
      )
    end

    let(:snake) do
      RbSnake::Models::Snake.new(
        body: [
          RbSnake::Models::Coordinate.new(row: 1, col: 1),
          RbSnake::Models::Coordinate.new(row: 0, col: 1),
          RbSnake::Models::Coordinate.new(row: 0, col: 0)
        ]
      )
    end
    let(:food) { RbSnake::Models::Food.new(row: 5, col: 5) }
    let(:grid) { RbSnake::Models::Grid.new(rows: 8, cols: 12) }
    let(:current_direction) { RbSnake::Models::Direction::DOWN }
    let(:game_finished) { false }
    let(:speed_factor) { 6 }
    let(:window) { RbSnake::Views::Window.new }

    before do
      allow(window).to receive(:render)
      described_class.call(state, window)
    end

    it "renders the window" do
      expect(window).to have_received(:render).with(state)
    end

    describe "when the snake can move to the next position" do
      let(:new_body) do
        [
          RbSnake::Models::Coordinate.new(row: 2, col: 1),
          RbSnake::Models::Coordinate.new(row: 1, col: 1),
          RbSnake::Models::Coordinate.new(row: 0, col: 1)
        ]
      end

      it "moves the snake to the next position" do
        expect(snake.body).to eql(new_body)
      end
    end

    describe "when the snake hits the food" do
      let(:food) { RbSnake::Models::Food.new(row: 2, col: 1) }

      it "increases the snake size" do
        expect(snake.body.size).to eq(4)
      end

      it "moves the food to a new position" do
        expect(food.location).not_to eql(RbSnake::Models::Coordinate.new(row: 2, col: 1))
      end
    end

    describe "when the snake hits itself" do
      let(:snake) do
        RbSnake::Models::Snake.new(
          body: [
            RbSnake::Models::Coordinate.new(row: 1, col: 1),
            RbSnake::Models::Coordinate.new(row: 0, col: 1),
            RbSnake::Models::Coordinate.new(row: 0, col: 0),
            RbSnake::Models::Coordinate.new(row: 1, col: 0)
          ]
        )
      end

      let(:current_direction) { RbSnake::Models::Direction::LEFT }

      it "finishes the game" do
        expect(state.game_finished).to eq(true)
      end
    end
  end
end
