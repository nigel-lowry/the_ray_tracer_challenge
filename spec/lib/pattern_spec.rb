require 'pattern'

class TestPattern < AbstractPattern
end

RSpec.describe Pattern do
  let(:color_a) { Color::WHITE }
  let(:color_b) { Color::BLACK }

  describe 'default transformation' do
    subject { TestPattern.new(color_a, color_b) }

    its(:transform) { is_expected.to eq(Transform::IDENTITY) }
  end

  describe '.stripe_pattern' do
    subject { Pattern.stripe_pattern(color_a, color_b) }

    it { is_expected.to have_attributes(a: color_a, b: color_b) }
  end

  describe '#stripe_at' do
    subject { Pattern.stripe_pattern(color_a, color_b) }

    context 'different y' do
      specify { expect(subject.stripe_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(0, 1, 0))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(0, 2, 0))).to eq(color_a) }
    end

    context 'different z' do
      specify { expect(subject.stripe_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(0, 0, 1))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(0, 0, 2))).to eq(color_a) }
    end

    context 'different x' do
      specify { expect(subject.stripe_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(0.1, 0, 0))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(0.9, 0, 0))).to eq(color_a) }
      specify { expect(subject.stripe_at(Point.new(1, 0, 0))).to eq(color_b) }
      specify { expect(subject.stripe_at(Point.new(1.1, 0, 0))).to eq(color_b) }
      specify { expect(subject.stripe_at(Point.new(-0.1, 0, 0))).to eq(color_b) }
      specify { expect(subject.stripe_at(Point.new(-1, 0, 0))).to eq(color_b) }
      specify { expect(subject.stripe_at(Point.new(-1.1, 0, 0))).to eq(color_a) }
    end
  end

  describe '#stripe_at_object' do
    let(:object) { Sphere.new }
    let(:transform) { Transform.scaling(2, 2, 2) }
    let(:pattern) { Pattern.stripe_pattern(Color::WHITE, Color::BLACK) }

    context 'object transformation' do
      before { object.transform = transform }

      specify { expect(pattern.stripe_at_object(object, Point.new(1.5, 0, 0))).to eq(Color::WHITE) }
    end

    context 'pattern transformation' do
      before { pattern.transform = transform }

      specify { expect(pattern.stripe_at_object(object, Point.new(1.5, 0, 0))).to eq(Color::WHITE) }
    end

    context 'both object and pattern transformation' do
      before do
        object.transform = transform
        pattern.transform = Transform.translation(0.5, 0, 0)
      end

      specify { expect(pattern.stripe_at_object(object, Point.new(2.5, 0, 0))).to eq(Color::WHITE) }
    end
  end
end