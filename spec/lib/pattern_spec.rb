require 'pattern'

class TestPattern < Pattern
  def initialize(a: Color::WHITE, b: Color::BLACK)
    super a, b
  end

  def pattern_at(point)
    Color.new(point.x, point.y, point.z)
  end
end

RSpec.describe Pattern do
  let(:color_a) { Color::WHITE }
  let(:color_b) { Color::BLACK }

  describe 'default transformation' do
    subject { TestPattern.new() }

    its(:transform) { is_expected.to eq(Transform::IDENTITY) }
  end

  describe 'stripe pattern' do
    subject { StripePattern.new(color_a, color_b) }

    it { is_expected.to have_attributes(a: color_a, b: color_b) }
  end

  describe '#pattern_at' do
    subject { StripePattern.new(color_a, color_b) }

    context 'different y' do
      specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 1, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 2, 0))).to eq(color_a) }
    end

    context 'different z' do
      specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 0, 1))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 0, 2))).to eq(color_a) }
    end

    context 'different x' do
      specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0.1, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0.9, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(1, 0, 0))).to eq(color_b) }
      specify { expect(subject.pattern_at(Point.new(1.1, 0, 0))).to eq(color_b) }
      specify { expect(subject.pattern_at(Point.new(-0.1, 0, 0))).to eq(color_b) }
      specify { expect(subject.pattern_at(Point.new(-1, 0, 0))).to eq(color_b) }
      specify { expect(subject.pattern_at(Point.new(-1.1, 0, 0))).to eq(color_a) }
    end
  end

  describe '#pattern_at_shape' do
    let(:object) { Sphere.new }
    let(:transform) { Transform.scaling(2, 2, 2) }
    let(:pattern) { TestPattern.new }

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
    let(:pattern) { TestPattern.new }
    let(:transform) { Transform.translation(1, 2, 3) }

    before { pattern.transform = transform }

    specify { expect(pattern.transform).to eq(transform) }
  end
end