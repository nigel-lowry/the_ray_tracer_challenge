require 'intersections'

RSpec.describe Intersections do
  describe '.initialize' do
    let(:s) { Sphere.new }
    let(:i1) { Intersection.new(1, s) }
    let(:i2) { Intersection.new(2, s) }
    subject { Intersections.new(i1, i2) }

    it 'contains the intersections' do
      expect(subject.count).to eq(2)
      expect(subject.first).to eq(i1)
      expect(subject.last).to eq(i2)
      expect(subject.first.t).to eq(1)
      expect(subject.last.t).to eq(2)
    end
  end
end