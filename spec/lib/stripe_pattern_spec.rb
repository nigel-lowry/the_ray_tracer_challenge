require 'stripe_pattern'

RSpec.describe StripePattern do
  let(:color_a) { Color::WHITE }
  let(:color_b) { Color::BLACK }
  
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
end