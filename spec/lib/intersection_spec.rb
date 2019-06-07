require 'intersection'

RSpec.describe Intersection do
  describe '.initialize' do
    let(:s) { Sphere.new }
    let(:i) { Intersection.new(3.5, s) }

    it 'allows access to its properties' do
      expect(i.t).to eq(3.5)
      expect(i.object).to eq(s)
    end
  end
end