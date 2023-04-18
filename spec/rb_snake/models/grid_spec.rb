# frozen_string_literal: true

require "spec_helper"
require "rb_snake/models/grid"

RSpec.describe RbSnake::Models::Grid do
  subject(:food) { described_class.new(rows: rows, cols: cols) }

  let(:rows) { 200 }
  let(:cols) { 800 }

  xit "does something great"
end
