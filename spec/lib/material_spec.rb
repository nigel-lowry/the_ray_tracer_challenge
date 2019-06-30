require 'material'

RSpec.describe Material do
  describe '.new' do
    subject { Material.new }

    its(:color) { is_expected.to eq(Color::WHITE) }
    its(:ambient) { is_expected.to eq(0.1) }
    its(:diffuse) { is_expected.to eq(0.9) }
    its(:specular) { is_expected.to eq(0.9) }
    its(:shininess) { is_expected.to eq(200.0) }
  end

  describe '#lighting' do
    let(:m) { Material.new }
    let(:position) { Point::ORIGIN }

    context 'lighting with the eye between the light and the surface' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(light, position, eye_v, normal_v)).to eq(Color.new(1.9, 1.9, 1.9)) }
    end

    context 'lighting with the eye between the light and the surface, eye offset 45 degrees' do
      let(:sqrt_of_2_divided_by_2) { Math::sqrt(2) / 2 }
      let(:eye_v) { Vector.new(0, sqrt_of_2_divided_by_2, -sqrt_of_2_divided_by_2) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(light, position, eye_v, normal_v)).to eq(Color.new(1.0, 1.0, 1.0)) }
    end

    context 'lighting with the eye opposite surface, light offset 45 degrees' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 10, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(light, position, eye_v, normal_v)).to closely_eq(Color.new(0.7364, 0.7364, 0.7364)) }
    end

    context 'lighting with the eye in the path of the reflection vector' do
      let(:sqrt_of_2_divided_by_2) { Math::sqrt(2) / 2 }
      let(:eye_v) { Vector.new(0, -sqrt_of_2_divided_by_2, -sqrt_of_2_divided_by_2) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 10, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(light, position, eye_v, normal_v)).to closely_eq(Color.new(1.6364, 1.6364, 1.6364)) }
    end

    context 'lighting with the light behind the surface' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, 10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(light, position, eye_v, normal_v)).to closely_eq(Color.new(0.1, 0.1, 0.1)) }
    end

    context 'lighting with the surface in shadow' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }
      let(:in_shadow) { true }

      specify { expect(m.lighting(light, position, eye_v, normal_v, in_shadow)).to closely_eq(Color.new(0.1, 0.1, 0.1)) }
    end
  end
end