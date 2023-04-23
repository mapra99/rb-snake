# frozen_string_literal: true

require "spec_helper"
require "rb_snake/models/state"
require "rb_snake/models/coordinate"
require "rb_snake/models/snake"
require "rb_snake/models/food"
require "rb_snake/models/grid"
require "rb_snake/models/direction"

RSpec.describe RbSnake::Models::State do
  subject(:state) do
    described_class.new(
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

  describe ".initial_state" do
    subject(:state) { described_class.initial_state }

    it "has an initial snake" do
      expect(state.snake).not_to be_nil
    end

    it "has an initial food" do
      expect(state.food).not_to be_nil
    end

    it "has a grid defined" do
      expect(state.grid).not_to be_nil
    end

    it "has an initial direction" do
      expect(state.current_direction).to eq(RbSnake::Models::Direction::DOWN)
    end

    it "is not finished" do
      expect(state.game_finished).to eq(false)
    end

    it "has initial speed factor of 6" do
      expect(state.speed_factor).to eq(6)
    end
  end

  describe "#finish_game!" do
    before do
      state.finish_game!
    end

    it "sets game_finished to true" do
      expect(state.game_finished).to eq(true)
    end
  end

  describe "#game_score" do
    it "returns the length of the snake" do
      expect(state.game_score).to eq(3)
    end
  end

  describe "#update_direction" do
    before do
      state.update_direction(RbSnake::Models::Direction::LEFT)
    end

    it "updates the current direction" do
      expect(state.current_direction).to eq(RbSnake::Models::Direction::LEFT)
    end
  end

  describe "#increase_speed" do
    before do
      state.increase_speed
    end

    it "decreases the speed factor" do
      expect(state.speed_factor).to eq(5)
    end

    context "when the speed factor is already 1" do
      let(:speed_factor) { 1 }

      it "does not decrease the speed factor" do
        expect(state.speed_factor).to eq(1)
      end
    end
  end
end
