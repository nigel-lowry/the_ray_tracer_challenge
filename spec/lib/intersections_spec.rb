require 'intersections'
require 'sphere'

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

  describe '#hit' do
    context 'all intersections have positive t' do
      let(:s) { Sphere.new }
      let(:i1) { Intersection.new(1, s) }
      let(:i2) { Intersection.new(2, s) }
      subject { Intersections.new(i1, i2) }

      its(:hit) { is_expected.to eq(i1) }
    end

    context 'some intersections have negative t' do
      let(:s) { Sphere.new }
      let(:i1) { Intersection.new(-1, s) }
      let(:i2) { Intersection.new(1, s) }
      subject { Intersections.new(i1, i2) }

      its(:hit) { is_expected.to eq(i2) }
    end

    context 'all intersections have negative t' do
      let(:s) { Sphere.new }
      let(:i1) { Intersection.new(-2, s) }
      let(:i2) { Intersection.new(-1, s) }
      subject { Intersections.new(i1, i2) }

      its(:hit) { is_expected.to be_nil }
    end

    context 'random order' do
      let(:s) { Sphere.new }
      let(:i1) { Intersection.new(5, s) }
      let(:i2) { Intersection.new(7, s) }
      let(:i3) { Intersection.new(-3, s) }
      let(:i4) { Intersection.new(2, s) }
      subject { Intersections.new(i1, i2, i3, i4) }

      its(:hit) { is_expected.to eq(i4) }
    end
  end
end