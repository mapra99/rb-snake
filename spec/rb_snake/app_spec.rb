# frozen_string_literal: true

require "spec_helper"
require "rb_snake/app"
require "ruby2d"

RSpec.describe RbSnake::App do
  subject(:app) { described_class.new }

  describe "#start" do
    let(:window) { instance_double(Ruby2D::Window, show: true, update: true, set: true, on: true) }

    before do
      allow(Ruby2D::Window).to receive(:new).and_return(window)

      app.start
    end

    it "creates a window" do
      expect(app.window).not_to be_nil
    end
  end
end
