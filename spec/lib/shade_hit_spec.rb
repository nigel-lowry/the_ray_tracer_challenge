require 'shade_hit'

RSpec.describe ShadeHit do
  describe '.new' do
    context 'shading intersection from outside' do
      let(:w) { World.default }
      let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
      let(:shape) { w.objects.first }
      let(:i) { Intersection.new(4, shape) }
      let(:comps) { PrepareComputations.new(i, r) }
      let(:c) { ShadeHit.new(w, comps) }

      specify { expect(c.color).to closely_eq(Color.new(0.38066, 0.47583, 0.2855)) }

      context 'multiple lights' do
        let(:w) { World.default }

        before { w.lights = [w.light, PointLight.new(Point.new(-20, 20, -20), Color.new(1, 0, 1))] }

        let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
        let(:shape) { w.objects.first }
        let(:i) { Intersection.new(4, shape) }
        let(:comps) { PrepareComputations.new(i, r) }
        let(:c) { ShadeHit.new(w, comps) }

        specify { expect(c.color).to closely_eq(Color.new(0.77293, 0.47583, 0.57969)) }
      end
    end

    context 'shading intersection from inside' do
      let(:w) { World.default }

      before { w.light = PointLight.new(Point.new(0, 0.25, 0), Color.new(1, 1, 1)) }

      let(:r) { Ray.new(Point.new(0, 0, 0), Vector.new(0, 0, 1)) }
      let(:shape) { w.objects.last }
      let(:i) { Intersection.new(0.5, shape) }
      let(:comps) { PrepareComputations.new(i, r) }
      let(:c) { ShadeHit.new(w, comps) }

      specify { expect(c.color).to closely_eq(Color.new(0.90498, 0.90498, 0.90498)) }
    end

    context 'intersection in shadow' do
      let(:w) { World.new }

      before { w.light = PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }

      let(:s1) { Sphere.new }
      let(:s2) { Sphere.new }

      before { s2.transform = Transform.translation(0, 0, 10) }
      before { w.objects = [s1, s2] }

      let(:r) { Ray.new(Point.new(0, 0, 5), Vector.new(0, 0, 1)) }
      let(:i) { Intersection.new(4, s2) }
      
      let(:comps) { PrepareComputations.new(i, r) }
      let(:c) { ShadeHit.new(w, comps) }

      specify { expect(c.color).to closely_eq(Color.new(0.1, 0.1, 0.1)) }
    end
  end
end