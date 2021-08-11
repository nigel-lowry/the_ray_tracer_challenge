require 'checker_pattern'

RSpec.describe CheckerPattern do
  describe '.pattern_at' do
    let(:color_a) { Color::WHITE }
    let(:color_b) { Color::BLACK }

    subject { CheckerPattern.new(a: color_a, b: color_b) }

    context 'x' do
      specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0.99, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(1.01, 0, 0))).to eq(color_b) }
    end

    context 'y' do
      specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 0.99, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 1.01, 0))).to eq(color_b) }
    end

    context 'z' do
      specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 0, 0.99))).to eq(color_a) }
      specify { expect(subject.pattern_at(Point.new(0, 0, 1.01))).to eq(color_b) }
    end
  end
end