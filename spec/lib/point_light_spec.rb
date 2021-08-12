require 'point_light'
require 'point'
require 'color'

RSpec.describe PointLight do
  describe '.new' do
    let(:position) { Point.new(0, 0, 0) }
    let(:intensity) { Color.new(1, 1, 1) }
    subject { PointLight.new(position, intensity)}

    it { is_expected.to have_attributes(position: position, intensity: intensity) }
  end
end