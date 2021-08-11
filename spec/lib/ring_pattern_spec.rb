require 'ring_pattern'

RSpec.describe RingPattern do
  let(:color_a) { Color::WHITE }
  let(:color_b) { Color::BLACK }

  subject { RingPattern.new(a: color_a, b: color_b) }

  specify { expect(subject.pattern_at(Point.new(0, 0, 0))).to eq(color_a) }
  specify { expect(subject.pattern_at(Point.new(1, 0, 0))).to eq(color_b) }
  specify { expect(subject.pattern_at(Point.new(0, 0, 1))).to eq(color_b) }
  specify { expect(subject.pattern_at(Point.new(0.708, 0, 0.708))).to eq(color_b) }
end