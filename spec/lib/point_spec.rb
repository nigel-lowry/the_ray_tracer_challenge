require 'point'

RSpec.describe Point do
  describe '.new' do
    subject { Point.new(1, 2, 3) }

    it { is_expected.to have_attributes(x: 1, y: 2, z: 3) }
    it { is_expected.to be_frozen }
  end

  describe '#tuple' do
    subject { Point.new(4, -4, 3).tuple }

    it { is_expected.to have_attributes(x: 4, y: -4, z: 3, w: 1) }
  end

  describe '#+' do
    context 'plus vector' do
      let(:p) { Point.new(3, -2, 5) } 
      let(:v) { Vector.new(-2, 3, 1) }
      subject { p + v }

      it { is_expected.to eq(Point.new(1, 1, 6)) }
    end

    context 'plus point' do
      let(:p1) { Point.new(3, -2, 5) }
      let(:p2) { Point.new(-2, 3, 1) }

      specify { expect { p1 + p2 }.to raise_error 'neither a point nor a vector' }
    end
  end

  describe '#-' do
    context 'minus point' do
      let(:p1) { Point.new(3, 2, 1) }
      let(:p2) { Point.new(5, 6, 7) }
      subject { p1 - p2 }

      it { is_expected.to eq(Vector.new(-2, -4, -6)) }
    end

    context 'minus vector' do
      let(:p) { Point.new(3, 2, 1) }
      let(:v) { Vector.new(5, 6, 7) }
      subject { p - v }

      it { is_expected.to eq(Point.new(-2, -4, -6)) }
    end
  end
end