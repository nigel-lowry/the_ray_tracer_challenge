require 'color'

RSpec.describe Color do
  describe 'construction' do
    subject { Color.new(-0.5, 0.4, 1.7) }

    its(:red) { is_expected.to eq(-0.5) }
    its(:green) { is_expected.to eq(0.4) }
    its(:blue) { is_expected.to eq(1.7) }
  end
end