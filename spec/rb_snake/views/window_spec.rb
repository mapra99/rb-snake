# frozen_string_literal: true

require "spec_helper"
require "ruby2d"
require "rb_snake/views/window"
require "rb_snake/models/state"

RSpec.describe RbSnake::Views::Window do
  subject(:window) { described_class.new }

  describe "#start" do
    let(:state) { RbSnake::Models::State.initial_state }
    let(:ruby2d_window) { instance_double(Ruby2D::Window, show: true, update: true, set: true, on: true) }

    before do
      allow(Ruby2D::Window).to receive(:new).and_return(ruby2d_window)

      window.start(state)
    end

    it "sets up the window" do
      expect(ruby2d_window).to have_received(:set)
    end

    it "sets up key listeners" do
      expect(ruby2d_window).to have_received(:on)
    end

    it "sets up the render loop" do
      expect(ruby2d_window).to have_received(:update)
    end
  end

  describe "#render" do
    let(:state) { RbSnake::Models::State.initial_state }
    let(:ruby2d_window) { instance_double(Ruby2D::Window, add: true) }

    let(:snake_length) { state.snake.body.length }

    before do
      allow(Ruby2D::Window).to receive(:new).and_return(ruby2d_window)
      allow(Ruby2D::Square).to receive(:new).and_return(true)

      window.render(state)
    end

    it "renders the snake and food" do
      expect(Ruby2D::Square).to have_received(:new).exactly(snake_length + 1).times
    end
  end
end
