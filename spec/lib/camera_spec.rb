require 'camera'

RSpec.describe Camera do
  describe '.new' do
    let(:hsize) { 160 }
    let(:vsize) { 120 }
    let(:field_of_view) { Math::PI / 2 }

    subject { Camera.new(hsize, vsize, field_of_view) }

    its(:hsize) { is_expected.to eq(160) }
    its(:vsize) { is_expected.to eq(120) }
    its(:field_of_view) { is_expected.to eq(Math::PI / 2) }
    its(:transform) { is_expected.to eq(Transform::IDENTITY) }
  end
end