require 'ray'

RSpec.describe Ray do
  describe '.new' do
    let(:origin) { Point.new(1, 2, 3) }
    let(:direction) { Vector.new(4, 5, 6) }
    subject { Ray.new(origin, direction) }

    its(:origin) { is_expected.to eq(origin) }
    its(:direction) { is_expected.to eq(direction) }
  end

  describe '#position' do
    let(:r) { Ray.new(Point.new(2, 3, 4), Vector.new(1, 0, 0)) }

    specify { expect(r.position(0)).to eq(Point.new(2, 3, 4)) }
    specify { expect(r.position(1)).to eq(Point.new(3, 3, 4)) }
    specify { expect(r.position(-1)).to eq(Point.new(1, 3, 4)) }
    specify { expect(r.position(2.5)).to eq(Point.new(4.5, 3, 4)) }
  end
end