require 'plane'

RSpec.describe Plane do
	specify { expect(subject.local_normal_at(Point.new(0, 0, 0))).to eq(Vector.new(0, 1, 0)) }
	specify { expect(subject.local_normal_at(Point.new(10, 0, -10))).to eq(Vector.new(0, 1, 0)) }
	specify { expect(subject.local_normal_at(Point.new(-5, 0, 150))).to eq(Vector.new(0, 1, 0)) }

	context 'parallel ray' do
		let(:r) { Ray.new(Point.new(0, 10, 0), Vector.new(0, 0, 1)) }

		specify { expect(subject.local_intersect(r)).to be_empty }
	end

	context 'coplanar ray' do
		let(:r) { Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1)) }

		specify { expect(subject.local_intersect(r)).to be_empty }
	end

	context 'ray intersecting from above' do
		let(:r) { Ray.new(Point.new(0, 1, 0), Vector.new(0, -1, 0)) }

		specify { expect(subject.local_intersect(r).intersections).to be_one }
		specify { expect(subject.local_intersect(r).intersections.first).to eq(Intersection.new(1, subject)) }
	end

	context 'ray intersecting from below' do
		let(:r) { Ray.new(Point.new(0, -1, 0), Vector.new(0, 1, 0)) }

		specify { expect(subject.local_intersect(r).intersections).to be_one }
		specify { expect(subject.local_intersect(r).intersections.first).to eq(Intersection.new(1, subject)) }
	end
end