require 'ray'
require 'point'
require 'transform'

RSpec.describe Ray do
  describe '.new' do
    let(:origin) { Point.new(1, 2, 3) }
    let(:direction) { Vector.new(4, 5, 6) }

    subject { Ray.new(origin, direction) }

    it { is_expected.to have_attributes(origin: origin, direction: direction) }
    it { is_expected.to be_frozen }
  end

  describe '#position' do
    let(:r) { Ray.new(Point.new(2, 3, 4), Vector.new(1, 0, 0)) }

    specify { expect(r.position(0)).to eq(Point.new(2, 3, 4)) }
    specify { expect(r.position(1)).to eq(Point.new(3, 3, 4)) }
    specify { expect(r.position(-1)).to eq(Point.new(1, 3, 4)) }
    specify { expect(r.position(2.5)).to eq(Point.new(4.5, 3, 4)) }
  end

  describe '#transform' do
    context 'translating' do
      let(:r) { Ray.new(Point.new(1, 2, 3), Vector.new(0, 1, 0)) }
      let(:m) { Transform.translation(3, 4, 5) }
      subject { r.transform(m) }

      its(:origin) { is_expected.to eq(Point.new(4, 6, 8)) }
      its(:direction) { is_expected.to eq(Vector.new(0, 1, 0)) }
      its(:direction) { is_expected.to be_a_unit_vector }
    end

    context 'scaling' do
      let(:r) { Ray.new(Point.new(1, 2, 3), Vector.new(0, 1, 0)) }
      let(:m) { Transform.scaling(2, 3, 4) }
      subject { r.transform(m) }

      its(:origin) { is_expected.to eq(Point.new(2, 6, 12)) }
      its(:direction) { is_expected.to eq(Vector.new(0, 3, 0)) }
      its(:direction) { is_expected.to_not be_a_unit_vector }

      it 'returns a new ray' do
        expect(subject).to_not equal(r)
      end

      it 'leaves the original ray unmodified' do
        expect(subject.origin).to_not eq(r.origin)
        expect(subject.direction).to_not eq(r.direction)
        expect(subject.origin).to_not equal(r.origin)
        expect(subject.direction).to_not equal(r.direction)
      end
    end
  end
end