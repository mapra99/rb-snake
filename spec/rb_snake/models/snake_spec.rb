# frozen_string_literal: true

require "spec_helper"
require "ruby2d"
require "rb_snake/models/snake"
require "rb_snake/models/coordinate"
require "rb_snake/models/grid"
require "rb_snake/models/food"

RSpec.describe RbSnake::Models::Snake do
  subject(:snake) { described_class.new(body: body) }

  let(:body) { [RbSnake::Models::Coordinate.new(row: 1, col: 1), RbSnake::Models::Coordinate.new(row: 0, col: 1)] }

  describe "#render" do
    let(:window) { instance_double(Ruby2D::Window) }

    before do
      allow(window).to receive(:remove).and_return(true)
    end

    context "when snake has not been rendered" do
      let(:body_length) { body.length }
      let(:rendered_body) { snake.send(:rendered_body) }

      before do
        snake.render(window) { "elem" }
      end

      it "saves the rendered body" do
        expect(rendered_body.length).to eq(body_length)
      end
    end

    context "when snake has changed its position after render" do
      let(:body_length) { body.length }
      let(:rendered_body) { snake.send(:rendered_body) }

      let(:old_tail) { RbSnake::Models::Coordinate.new(row: 0, col: 1) }
      let(:new_head) { RbSnake::Models::Coordinate.new(row: 2, col: 1) }

      before do
        snake.render(window) { "elem" }
        snake.move_to(new_head)
        snake.render(window) { "elem" }
      end

      it "saves the rendered body" do
        expect(rendered_body.length).to eq(body_length)
      end

      it "removes the previous tail position from the window" do
        expect(window).to have_received(:remove).once
      end

      it "removes the stored rendered tail" do
        expect(rendered_body.map(&:position)).not_to include(old_tail)
      end

      it "stores the new rendered head" do
        expect(rendered_body.first.position).to eq(new_head)
      end
    end
  end

  describe "#next_position" do
    subject(:next_position) { snake.next_position(direction, grid) }

    let(:grid) { RbSnake::Models::Grid.new(rows: 10, cols: 10) }

    context "when the snake is moving right" do
      let(:direction) { :right }

      it "returns the next position to the right" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 1, col: 2))
      end
    end

    context "when the snake is moving left" do
      let(:direction) { :left }

      it "returns the next position to the left" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 1, col: 0))
      end
    end

    context "when the snake is moving up" do
      let(:direction) { :up }

      it "returns the next position to the up" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 0, col: 1))
      end
    end

    context "when the snake is moving down" do
      let(:direction) { :down }

      it "returns the next position to the down" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 2, col: 1))
      end
    end

    context "when snake is in the last row and is moving down" do
      let(:body) { [RbSnake::Models::Coordinate.new(row: 9, col: 1), RbSnake::Models::Coordinate.new(row: 8, col: 1)] }
      let(:direction) { :down }

      it "returns the next position back on top of the grid" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 0, col: 1))
      end
    end

    context "when snake is in the first row and is moving up" do
      let(:body) { [RbSnake::Models::Coordinate.new(row: 0, col: 1), RbSnake::Models::Coordinate.new(row: 1, col: 1)] }
      let(:direction) { :up }

      it "returns the next position back on bottom of the grid" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 9, col: 1))
      end
    end

    context "when snake is in the first col and is moving left" do
      let(:body) { [RbSnake::Models::Coordinate.new(row: 0, col: 0), RbSnake::Models::Coordinate.new(row: 0, col: 1)] }
      let(:direction) { :left }

      it "returns the next position back on the right of the grid" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 0, col: 9))
      end
    end

    context "when snake is in the last col and is moving right" do
      let(:body) { [RbSnake::Models::Coordinate.new(row: 0, col: 9), RbSnake::Models::Coordinate.new(row: 0, col: 8)] }
      let(:direction) { :right }

      it "returns the next position back on the right of the grid" do
        expect(next_position).to eql(RbSnake::Models::Coordinate.new(row: 0, col: 0))
      end
    end
  end

  describe "#eat" do
    let(:food) { RbSnake::Models::Food.new(row: 2, col: 1) }

    before do
      snake.eat(food)
    end

    it "adds the food to the snake body" do
      expect(snake.body).to include(food.location)
    end
  end

  describe "#move_to" do
    let(:new_head) { RbSnake::Models::Coordinate.new(row: 2, col: 1) }
    let(:old_tail) { RbSnake::Models::Coordinate.new(row: 0, col: 1) }

    before do
      snake.move_to(new_head)
    end

    it "moves the snake to the new head" do
      expect(snake.body.first).to eql(new_head)
    end

    it "removes the previous tail position" do
      expect(snake.body.last).not_to eql(old_tail)
    end
  end
end
