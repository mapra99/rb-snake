# frozen_string_literal: true

require "spec_helper"
require "ruby2d"
require "rb_snake/models/food"
require "rb_snake/models/snake"
require "rb_snake/models/grid"
require "rb_snake/models/coordinate"

RSpec.describe RbSnake::Models::Food do
  subject(:food) { described_class.new(row: row, col: col) }

  let(:row) { 1 }
  let(:col) { 2 }

  describe "#render" do
    let(:window) { instance_double(Ruby2D::Window) }

    before do
      allow(window).to receive(:remove).and_return(true)
    end

    context "when food has not been rendered" do
      before do
        food.render(window) { "elem" }
      end

      it "stores the rendered element" do
        expect(food.send(:rendered_element)).not_to be_nil
      end
    end

    context "when the food is already rendered" do
      before do
        food.render(window) { "elem" }
      end

      it "does not render the food on the window" do
        expect(window).not_to have_received(:remove)
      end
    end

    context "when food has been relocated" do
      let(:snake) { RbSnake::Models::Snake.new(body: []) }
      let(:grid) { RbSnake::Models::Grid.new(rows: 10, cols: 10) }

      before do
        food.render(window) { "elem" }
        food.regenerate(snake, grid)
        food.render(window) { "elem" }
      end

      it "removes the existing food from window" do
        expect(window).to have_received(:remove)
      end
    end
  end

  describe "#regenerate" do
    let(:snake) { RbSnake::Models::Snake.new(body: []) }
    let(:grid) { RbSnake::Models::Grid.new(rows: 10, cols: 10) }

    let(:current_location) { RbSnake::Models::Coordinate.new(row: row, col: col) }

    before do
      food.regenerate(snake, grid)
    end

    it "generates a new location" do
      expect(food.location).not_to eq(current_location)
    end
  end
end
