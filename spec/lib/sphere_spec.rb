require 'sphere'

RSpec.describe Sphere do
  describe '.initialize' do
    subject { Sphere.new }

    its(:radius) { is_expected.to eq(1.0) }

    it 'returns a new object each time' do
      expect(subject).not_to be(Sphere.new)
    end
  end
end