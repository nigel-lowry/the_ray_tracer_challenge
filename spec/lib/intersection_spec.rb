require 'intersection'
require 'sphere'

RSpec.describe Intersection do
  describe '.initialize' do
    let(:s) { Sphere.new }

    subject { Intersection.new(3.5, s) }

    it { is_expected.to have_attributes(t: 3.5, object: s) }
  end
end