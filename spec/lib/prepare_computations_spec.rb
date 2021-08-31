require 'prepare_computations'
require 'sphere'

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
      specify { expect(comps).to_not be_inside }
      specify { expect(comps).to be_outside }
    end

    context 'intersection on inside' do
      let(:r) { Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1)) }
      let(:shape) { Sphere.new }
      let(:i) { Intersection.new(1, shape) }
      let(:comps) { PrepareComputations.new(i, r) }

      specify { expect(comps.point).to eq(Point.new(0, 0, 1)) }
      specify { expect(comps.eyev).to eq(Vector.new(0, 0, -1)) }
      specify { expect(comps.inside).to be true }
      specify { expect(comps).to be_inside }
      specify { expect(comps).to_not be_outside }
      specify { expect(comps.normalv).to eq(Vector.new(0, 0, -1)) }
    end
  end

  describe '#over_point' do
    let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
    let(:shape) { Sphere.new }

    before { shape.transform = Transform.translation(0, 0, 1) }

    let(:i) { Intersection.new(5, shape) }
    let(:comps) { PrepareComputations.new(i, r) }

    specify { expect(comps.over_point.z).to be < -EPSILON / 2 }
    specify { expect(comps.point.z).to be > comps.over_point.z }
  end

  describe '#reflectv' do
    let(:r) { Ray.new(Point.new(0, 1, -1), Vector.new(0, -Math::sqrt(2) / 2, Math::sqrt(2) / 2)) }
    let(:shape) { Plane.new }
    let(:i) { Intersection.new(Math::sqrt(2), shape) }

    let(:comps) { PrepareComputations.new(i, r) }

    specify { expect(comps.reflectv).to closely_eq(Vector.new(0, Math::sqrt(2) / 2, Math::sqrt(2) / 2)) }    
  end
end