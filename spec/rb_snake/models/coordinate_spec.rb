# frozen_string_literal: true

require "spec_helper"
require "rb_snake/models/coordinate"

RSpec.describe RbSnake::Models::Coordinate do
  subject(:coordinate) { described_class.new(row: row, col: col) }

  let(:row) { 1 }
  let(:col) { 2 }

  xit "does something great"
end
