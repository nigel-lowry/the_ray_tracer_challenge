require 'gradient_pattern'

RSpec.describe GradientPattern do
  let(:color_a) { Color::WHITE }
  let(:color_b) { Color::BLACK }

  subject { GradientPattern.new(color_a, color_b) }

  specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
  specify { expect(subject.pattern_at(Point.new(0.25, 0, 0))).to eq(Color.new(0.75, 0.75, 0.75)) }
  specify { expect(subject.pattern_at(Point.new(0.5, 0, 0))).to eq(Color.new(0.5, 0.5, 0.5)) }
  specify { expect(subject.pattern_at(Point.new(0.75, 0, 0))).to eq(Color.new(0.25, 0.25, 0.25)) }
end