require 'ray'

RSpec.describe Ray do
  describe '.new' do
    let(:origin) { Point.new(1, 2, 3) }
    let(:direction) { Vector.new(4, 5, 6) }
    subject { Ray.new(origin, direction) }

    its(:origin) { is_expected.to eq(origin) }
    its(:direction) { is_expected.to eq(direction) }
  end
end