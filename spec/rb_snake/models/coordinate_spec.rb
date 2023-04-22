# frozen_string_literal: true

require "spec_helper"
require "rb_snake/models/coordinate"

RSpec.describe RbSnake::Models::Coordinate do
  subject(:coordinate) { described_class.new(row: row, col: col) }

  let(:row) { 1 }
  let(:col) { 2 }

  describe "#eql?" do
    subject { coordinate.eql?(other) }

    let(:other) { described_class.new(row: other_row, col: other_col) }

    let(:other_row) { 1 }
    let(:other_col) { 2 }

    it { is_expected.to be true }

    context "when row is different" do
      let(:other_row) { 2 }

      it { is_expected.to be false }
    end

    context "when col is different" do
      let(:other_col) { 3 }

      it { is_expected.to be false }
    end
  end
end
