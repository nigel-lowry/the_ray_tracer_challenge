require 'material'

RSpec.describe Material do
  describe '.new' do
    subject { Material.new }

    its(:color) { is_expected.to eq(Color::WHITE) }
    its(:ambient) { is_expected.to eq(0.1) }
    its(:diffuse) { is_expected.to eq(0.9) }
    its(:specular) { is_expected.to eq(0.9) }
    its(:shininess) { is_expected.to eq(200.0) }
  end
end