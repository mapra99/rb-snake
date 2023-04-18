require "spec_helper"
require "rb_snake/models/direction"

RSpec.describe RbSnake::Models::Direction do
  it "has the up direction defined" do
    expect(described_class::UP).to eq(:up)
  end

  it "has the right direction defined" do
    expect(described_class::RIGHT).to eq(:right)
  end

  it "has the down direction defined" do
    expect(described_class::DOWN).to eq(:down)
  end

  it "has the left direction defined" do
    expect(described_class::LEFT).to eq(:left)
  end
end
