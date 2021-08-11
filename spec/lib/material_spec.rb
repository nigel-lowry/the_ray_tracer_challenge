require 'material'

RSpec.describe Material do
  describe '.new' do
    subject { Material.new }

    specify { expect(subject).to have_attributes(color: Color::WHITE, ambient: 0.1, diffuse: 0.9, specular: 0.9, shininess: 200.0) }
  end

  describe '::DEFAULT' do
    subject { Material::DEFAULT }

    specify { expect(subject).to have_attributes(color: Color::WHITE, ambient: 0.1, diffuse: 0.9, specular: 0.9, shininess: 200.0) }
    specify { expect(subject).to eq(Material.new) }
  end

  describe '#lighting' do
    let(:m) { Material.new }
    let(:position) { Point::ORIGIN }
    let(:object) { Sphere.new }

    context 'lighting with the eye between the light and the surface' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(object, light, position, eye_v, normal_v)).to eq(Color.new(1.9, 1.9, 1.9)) }
    end

    context 'lighting with the eye between the light and the surface, eye offset 45 degrees' do
      let(:sqrt_of_2_divided_by_2) { Math::sqrt(2) / 2 }
      let(:eye_v) { Vector.new(0, sqrt_of_2_divided_by_2, -sqrt_of_2_divided_by_2) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(object, light, position, eye_v, normal_v)).to eq(Color.new(1.0, 1.0, 1.0)) }
    end

    context 'lighting with the eye opposite surface, light offset 45 degrees' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 10, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(object, light, position, eye_v, normal_v)).to closely_eq(Color.new(0.7364, 0.7364, 0.7364)) }
    end

    context 'lighting with the eye in the path of the reflection vector' do
      let(:sqrt_of_2_divided_by_2) { Math::sqrt(2) / 2 }
      let(:eye_v) { Vector.new(0, -sqrt_of_2_divided_by_2, -sqrt_of_2_divided_by_2) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 10, -10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(object, light, position, eye_v, normal_v)).to closely_eq(Color.new(1.6364, 1.6364, 1.6364)) }
    end

    context 'lighting with the light behind the surface' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, 10), Color.new(1, 1, 1)) }

      specify { expect(m.lighting(object, light, position, eye_v, normal_v)).to closely_eq(Color.new(0.1, 0.1, 0.1)) }
    end

    context 'lighting with the surface in shadow' do
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color.new(1, 1, 1)) }
      let(:in_shadow) { true }

      specify { expect(m.lighting(object, light, position, eye_v, normal_v, in_shadow)).to closely_eq(Color.new(0.1, 0.1, 0.1)) }
    end

    context 'lighting with a pattern' do
      let(:pattern) { Pattern.stripe_pattern(Color::WHITE, Color::BLACK) }
      let(:m) { Material.new(pattern: pattern, ambient: 1, diffuse: 0, specular: 0) }
      let(:eye_v) { Vector.new(0, 0, -1) }
      let(:normal_v) { Vector.new(0, 0, -1) }
      let(:light) { PointLight.new(Point.new(0, 0, -10), Color::WHITE) }

      specify { expect(m.lighting(object, light, Point.new(0.9, 0, 0), eye_v, normal_v, false)).to eq(Color::WHITE) }
      specify { expect(m.lighting(object, light, Point.new(1.1, 0, 0), eye_v, normal_v, false)).to eq(Color::BLACK) }
    end
  end
end