require 'ppm_canvas_writer'
require 'canvas'

RSpec.describe PpmCanvasWriter do

  describe '#to_s' do
    let(:canvas) { Canvas.new(5, 3) }
    let(:canvas_writer) { PpmCanvasWriter.new(canvas) }
    let(:c1) { Color.new(1.5, 0, 0) }
    let(:c2) { Color.new(0, 0.5, 0) }
    let(:c3) { Color.new(-0.5, 0, 1) }
    
    before do
      canvas.write_pixel(0, 0, c1)
      canvas.write_pixel(2, 1, c2)
      canvas.write_pixel(4, 2, c3)
    end

    describe 'PPM header' do
      it 'has the identifier, then the width and height, then the maximum color value' do
        expect(canvas_writer.to_s).to start_with("P3\n5 3\n255\n")
      end
    end

    describe 'pixel data' do
      it 'has the components laid out as integers' do
        expect(canvas_writer.to_s).to end_with(
          "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n" +
          "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0\n" +
          "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255\n"
        )
      end
    end

    describe 'contents' do
      let(:expected) do
        <<-EXPECTED
P3
5 3
255
255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
        EXPECTED
      end

      subject { canvas_writer.to_s }

      it { is_expected.to eq(expected) }
      it { is_expected.to end_with("\n") }
    end
  end

  describe 'splitting long lines' do
    let(:color) { Color.new(1, 0.8, 0.6) }
    let(:canvas) { Canvas.new(10, 2, color) }
    let(:canvas_writer) { PpmCanvasWriter.new(canvas) }

    it 'keeps long lines no more than 70 characters' do
      expect(canvas_writer.to_s).to end_with(
        "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204\n" +
        "153 255 204 153 255 204 153 255 204 153 255 204 153\n" +
        "255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204\n" +
        "153 255 204 153 255 204 153 255 204 153 255 204 153\n"
      )
    end
  end
end