require 'canvas'

RSpec.describe Canvas do
  subject { Canvas.new(10, 20) }

  describe '.new' do
    it { is_expected.to have_attributes(width: 10, height: 20) }
    
    specify { expect(subject.to_a).to all be_black }

    specify { expect { Canvas.new(0, 0) }.to raise_error 'canvas has no pixels' }
    specify { expect { Canvas.new(0, 10) }.to raise_error 'canvas has no pixels' }
    specify { expect { Canvas.new(10, 0) }.to raise_error 'canvas has no pixels' }

    specify { expect { Canvas.new(-10, 10) }.to raise_error 'negative array size' }
    specify { expect { Canvas.new(10, -10) }.to raise_error 'negative array size'}
    specify { expect { Canvas.new(-10, -10) }.to raise_error 'negative array size' }

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

    it 'keeps other pixels black' do
      expect(subject.pixel_at(0, 0)).to be_black
    end
  end

  describe 'boundaries' do
    subject { Canvas.new(3, 2) }
    let(:red) { Color.new(1, 0, 0) }

    context 'inside' do
      it 'returns black pixels' do
        expect([
          subject.pixel_at(0, 0), subject.pixel_at(1, 0), subject.pixel_at(2, 0),
          subject.pixel_at(0, 1), subject.pixel_at(1, 1), subject.pixel_at(2, 1)  
        ]).to all be_black
      end
    end

    context 'outside' do
      context 'negative x' do
        it 'errors' do
          expect { subject.pixel_at(-1, 0) }.to raise_error 'outside bounds'
          expect { subject.write_pixel(-1, 0, red) }.to raise_error 'outside bounds'
        end
      end

      context 'x > width' do
        it 'errors' do
          expect { subject.pixel_at(3, 0) }.to raise_error 'outside bounds'
          expect { subject.write_pixel(3, 0, red) }.to raise_error 'outside bounds'
        end
      end

      context 'negative y' do
        it 'errors' do
          expect { subject.pixel_at(0, -1) }.to raise_error 'outside bounds'
          expect { subject.write_pixel(0, -1, red) }.to raise_error 'outside bounds'
        end
      end

      context 'y > height' do
        it 'errors' do
          expect { subject.pixel_at(0, 2) }.to raise_error 'outside bounds'
          expect { subject.write_pixel(0, 2, red) }.to raise_error 'outside bounds'
        end
      end
    end
  end
end