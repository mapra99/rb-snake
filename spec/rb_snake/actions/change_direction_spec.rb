# frozen_string_literal: true

require "spec_helper"
require "rb_snake/actions/change_direction"
require "rb_snake/models/state"

RSpec.describe RbSnake::Actions::ChangeDirection do
  describe ".call" do
    let(:state) { RbSnake::Models::State.initial_state }
    let(:new_direction) { RbSnake::Models::Direction::RIGHT }

    before do
      described_class.call(state, new_direction: new_direction)
    end

    it "updates the direction" do
      expect(state.current_direction).to eq(new_direction)
    end

    context "when the new direction is invalid" do
      let(:new_direction) { RbSnake::Models::Direction::UP }

      it "does not update the direction" do
        expect(state.current_direction).to eq(RbSnake::Models::Direction::DOWN)
      end
    end
  end
end
