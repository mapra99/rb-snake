# frozen_string_literal: true

require "spec_helper"
require "rb_snake/actions/change_direction"
require "rb_snake/actions/move_snake"
require "rb_snake/models/state"

RSpec.describe RbSnake::Actions::ChangeDirection do
  describe ".call" do
    let(:state) { RbSnake::Models::State.initial_state }
    let(:window) { RbSnake::Views::Window.new }
    let(:new_direction) { RbSnake::Models::Direction::RIGHT }

    before do
      allow(RbSnake::Actions::MoveSnake).to receive(:call)
      described_class.call(state, window, new_direction: new_direction)
    end

    it "updates the direction" do
      expect(state.current_direction).to eq(new_direction)
    end

    it "moves the snake" do
      expect(RbSnake::Actions::MoveSnake).to have_received(:call).with(state, window)
    end

    context "when the new direction is invalid" do
      let(:new_direction) { RbSnake::Models::Direction::UP }

      it "does not update the direction" do
        expect(state.current_direction).to eq(RbSnake::Models::Direction::DOWN)
      end
    end
  end
end
