require 'world'

RSpec.describe World do
  describe '.new' do
    let(:w) { World.new }

    specify { expect(w.objects).to be_empty }
    specify { expect(w.light).to be_nil }
  end

  describe '.default' do
    let(:w) { World.default }

    specify { expect(w.light).to eq(PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1))) }
  end
end