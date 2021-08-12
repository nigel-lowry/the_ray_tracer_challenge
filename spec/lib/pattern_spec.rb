require 'pattern'
require 'sphere'

class TestPattern < Pattern
  def initialize(a, b)
    super
  end

  def pattern_at(point)
    Color.new(point.x, point.y, point.z)
  end
end

RSpec.describe Pattern do
  let(:color_a) { Color::WHITE }
  let(:color_b) { Color::BLACK }
  let(:pattern) { TestPattern.new(color_a, color_b) }

  describe 'attributes' do
    subject { pattern }

    it { is_expected.to have_attributes(a: color_a, b: color_b) }
    its(:transform) { is_expected.to eq(Transform::IDENTITY) }
  end

  describe '#pattern_at_shape' do
    let(:object) { Sphere.new }
    let(:transform) { Transform.scaling(2, 2, 2) }

    context 'object transformation' do
      before { object.transform = transform }

      specify { expect(pattern.pattern_at_shape(object, Point.new(2, 3, 4))).to eq(Color.new(1, 1.5, 2)) }
    end

    context 'pattern transformation' do
      before { pattern.transform = transform }

      specify { expect(pattern.pattern_at_shape(object, Point.new(2, 3, 4))).to eq(Color.new(1, 1.5, 2)) }
    end

    context 'both object and pattern transformation' do
      before do
        object.transform = transform
        pattern.transform = Transform.translation(0.5, 1, 1.5)
      end

      specify { expect(pattern.pattern_at_shape(object, Point.new(2.5, 3, 3.5))).to eq(Color.new(0.75, 0.5, 0.25)) }
    end
  end

  describe '#transform=' do
    let(:transform) { Transform.translation(1, 2, 3) }

    before { pattern.transform = transform }

    specify { expect(pattern.transform).to eq(transform) }
  end
end