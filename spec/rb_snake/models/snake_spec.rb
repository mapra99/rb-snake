# frozen_string_literal: true

require "spec_helper"
require "rb_snake/models/snake"
require "rb_snake/models/coordinate"

RSpec.describe RbSnake::Models::Snake do
  subject(:snake) { described_class.new(body: body) }

  let(:body) { [RbSnake::Models::Coordinate.new(row: 1, col: 1), RbSnake::Models::Coordinate.new(row: 0, col: 1)] }

  xit "does something great"
end
