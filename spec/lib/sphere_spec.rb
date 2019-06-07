require 'sphere'

RSpec.describe Sphere do
  describe '.initialize' do
    subject { Sphere.new }

    its(:radius) { is_expected.to eq(1.0) }

    it 'returns a new object each time' do
      expect(subject).not_to be(Sphere.new)
    end
  end

  describe '#intersect' do
    context 'not tangential' do
      let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
      let(:s) { Sphere.new }

      it 'intersects at two points' do
        xs = s.intersect(r)

        expect(xs.count).to eq(2)
        expect(xs.first).to eq(Intersection.new(4.0, s))
        expect(xs.last).to eq(Intersection.new(6.0, s))
        expect(xs.first.object).to eq(s)
        expect(xs.last.object).to eq(s)
      end
    end

    context 'at a tangent' do
      let(:r) { Ray.new(Point.new(0, 1, -5), Vector.new(0, 0, 1)) }
      let(:s) { Sphere.new }

      it 'intersects at one point' do
        xs = s.intersect(r)

        expect(xs.count).to eq(2)
        expect(xs.first).to eq(Intersection.new(5.0, s))
        expect(xs.last).to eq(Intersection.new(5.0, s))
      end
    end

    context 'not intersecting' do
      let(:r) { Ray.new(Point.new(0, 2, -5), Vector.new(0, 0, 1)) }
      let(:s) { Sphere.new }

      it 'has no intersections' do
        xs = s.intersect(r)

        expect(xs).to be_empty
      end
    end

    context 'ray originate inside sphere' do
      let(:r) { Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1)) }
      let(:s) { Sphere.new }

      it 'has an intersection behind the starting point too' do
        xs = s.intersect(r)

        expect(xs.count).to eq(2)
        expect(xs.first).to eq(Intersection.new(-1.0, s))
        expect(xs.last).to eq(Intersection.new(1.0, s))
      end
    end

    context 'ray originates after sphere' do
      let(:r) { Ray.new(Point.new(0, 0, 5), Vector.new(0, 0, 1)) }
      let(:s) { Sphere.new }

      it 'has two intersections behind' do
        xs = s.intersect(r)

        expect(xs.count).to eq(2)
        expect(xs.first).to eq(Intersection.new(-6.0, s))
        expect(xs.last).to eq(Intersection.new(-4.0, s))
      end
    end

    context 'transformed' do
      context 'scaled' do
        let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
        let(:s) { Sphere.new }
        let(:t) { Transform.scaling(2, 2, 2) }

        before { s.transform = t }

        it 'intersects' do
          xs = s.intersect(r)

          expect(xs.count).to eq(2)
          expect(xs.first.t).to eq(3)
          expect(xs.last.t).to eq(7)
        end
      end

      context 'translated' do
        let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
        let(:s) { Sphere.new }
        let(:t) { Transform.translation(5, 0, 0) }

        before { s.transform = t }

        it 'does not intersect' do
          xs = s.intersect(r)

          expect(xs.count).to eq(0)
        end
      end
    end
  end

  describe '#transform' do
    context 'default transformation' do
      let(:s) { Sphere.new }

      it 'is the identity transform' do
        expect(s.transform).to eq(Matrix::IDENTITY_4X4)
      end 
    end

    context 'set transformation' do
      let(:s) { Sphere.new }
      let(:t) { Transform.translation(2, 3, 4) }

      before { s.transform = t }

      specify { expect(s.transform).to eq(t) }
    end
  end
end