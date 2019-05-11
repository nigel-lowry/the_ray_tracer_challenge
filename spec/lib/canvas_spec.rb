require 'canvas'

RSpec.describe Canvas do
  subject { Canvas.new(10, 20) }

  describe '.new' do
    it { is_expected.to have_attributes(width: 10, height: 20) }

    specify 'every pixel is black' do
      expect(subject.to_a).to all be_black
    end

    context 'zero pixels' do
      it 'errors' do
        expect { Canvas.new(0, 0) }.to raise_error 'canvas has no pixels'
      end
    end

    context 'row of pixels' do
      subject { Canvas.new(10, 1) }

      it { is_expected.to have_attributes(width: 10, height: 1) }
    end

    context 'column of pixels' do
      subject { Canvas.new(1, 10) }

      it { is_expected.to have_attributes(width: 1, height: 10) }
    end
  end

  describe '#write_pixel' do
    let(:red) { Color.new(1, 0, 0) }
    before { subject.write_pixel(2, 3, red) }

    it 'changes the pixel color' do
      expect(subject.pixel_at(2, 3)).to eq(red)
    end
  end
end