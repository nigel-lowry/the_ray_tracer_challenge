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
end