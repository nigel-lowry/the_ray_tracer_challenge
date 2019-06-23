require 'prepare_computations'

RSpec.describe PrepareComputations do
  describe '.new' do
    let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
    let(:shape) { Sphere.new }
    let(:i) { Intersection.new(4, shape) }
    let(:comps) { PrepareComputations.new(i, r) }

    specify { expect(comps.t).to eq(i.t) }
    specify { expect(comps.object).to eq(i.object) }
    specify { expect(comps.point).to eq(Point.new(0, 0, -1)) }
    specify { expect(comps.eyev).to eq(Vector.new(0, 0, -1)) }
    specify { expect(comps.normalv).to eq(Vector.new(0, 0, -1)) }

    context 'intersection on outside' do
      let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
      let(:shape) { Sphere.new }
      let(:i) { Intersection.new(4, shape) }
      let(:comps) { PrepareComputations.new(i, r) }

      specify { expect(comps.inside).to be false }
    end

    context 'intersection on inside' do
      let(:r) { Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1)) }
      let(:shape) { Sphere.new }
      let(:i) { Intersection.new(1, shape) }
      let(:comps) { PrepareComputations.new(i, r) }

      specify { expect(comps.point).to eq(Point.new(0, 0, 1)) }
      specify { expect(comps.eyev).to eq(Vector.new(0, 0, -1)) }
      specify { expect(comps.inside).to be true }
      specify { expect(comps.normalv).to eq(Vector.new(0, 0, -1)) }
    end
  end
end