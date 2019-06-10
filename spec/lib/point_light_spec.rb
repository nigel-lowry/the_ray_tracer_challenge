require 'point_light'

RSpec.describe PointLight do
  describe '.new' do
    let(:position) { Point.new(0, 0, 0) }
    let(:intensity) { Color.new(1, 1, 1) }
    let(:light) { PointLight.new(position, intensity)}

    specify { expect(light.position).to eq(position) }
    specify { expect(light.intensity).to eq(intensity) }
  end
end