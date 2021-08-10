require 'point_light'

RSpec.describe PointLight do
  describe '.new' do
    let(:position) { Point.new(0, 0, 0) }
    let(:intensity) { Color.new(1, 1, 1) }
    subject { PointLight.new(position, intensity)}

    it { is_expected.to have_attributes(position: position, intensity: intensity) }
  end
end