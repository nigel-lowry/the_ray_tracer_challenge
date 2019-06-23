require 'world'

RSpec.describe World do
  describe '.new' do
    let(:w) { World.new }

    specify { expect(w.objects).to be_empty }
    specify { expect(w.light).to be_nil }
  end

  describe '.default' do
    let(:w) { World.default }
    let(:s1) { Sphere.new }
    let(:s2) { Sphere.new }

    before do
      material = Material.new()

      material.color = Color.new(0.8, 1.0, 0.6)
      material.diffuse = 0.7
      material.specular = 0.2

      s1.material = material

      s2.transform = Transform.scaling(0.5, 0.5, 0.5)
    end

    specify { expect(w.light).to eq(PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1))) }
    specify { expect(w.objects).to contain_exactly(s1, s2) }
  end

  describe '#intersect' do
    let(:w) { World.default }
    let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
    let(:xs) { w.intersect(r) }

    specify { expect(xs.count).to eq(4) }
    specify { expect(xs[0].t).to eq(4) }
    specify { expect(xs[1].t).to eq(4.5) }
    specify { expect(xs[2].t).to eq(5.5) }
    specify { expect(xs[3].t).to eq(6) }
  end

  describe '#light' do
    context 'one light' do
      let(:light) { PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1)) } 
      let(:w) { World.new nil, light }

      specify { expect(w.light).to eq(light) }
      specify { expect(w.lights).to eq([light]) }
    end

    context 'two lights' do
      let(:light1) { PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1)) } 
      let(:light2) { PointLight.new(Point.new(-20, 20, -20), Color.new(1, 1, 1)) } 
      let(:w) { World.new nil, [light1, light2] }

      specify { expect { w.light }.to raise_error('multiple lights') }
      specify { expect(w.lights).to eq([light1, light2]) }
    end
  end

  describe '#color_at' do
    context 'ray misses' do
      let(:w) { World.default }
      let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 1, 0)) }

      specify { expect(w.color_at(r)).to eq(Color::BLACK) }
    end

    context 'ray hits' do
      let(:w) { World.default }
      let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }

      specify { expect(w.color_at(r)).to closely_eq(Color.new(0.38066, 0.47583, 0.2855)) }
    end

    context 'intesection behind the ray' do
      let(:w) { World.default }
      let(:outer) { w.objects.first }
      let(:inner) { w.objects.last }
      let(:r) { Ray.new(Point.new(0, 0, 0.75), Vector.new(0, 0, -1)) }

      before { outer.material.ambient = inner.material.ambient = 1 }
      
      specify { expect(w.color_at(r)).to eq(inner.material.color) }
    end
  end
end