require 'ppm_canvas_writer'

RSpec.describe CanvasWriter do

  describe '#to_s' do
    let(:canvas) { Canvas.new(5, 3) }
    let(:canvas_writer) { CanvasWriter.new(canvas) }
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
        expect(canvas_writer.to_s).to start_with("P3\n5 3\n255")
      end
    end

    describe 'pixel data' do
      it 'has the components laid out as integers' do
        expect(canvas_writer.to_s).to end_with(
          "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n" +
          "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0\n" +
          "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255"
        )
      end
    end
  end
end