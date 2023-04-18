require "spec_helper"
require "rb_snake/models/food"

RSpec.describe RbSnake::Models::Food do
  subject(:food) { described_class.new(row: row, col: col) }

  let(:row) { 1 }
  let(:col) { 2 }

  xit "does something great"
end
