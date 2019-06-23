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

  describe '#pixel_size' do
    context 'landscape' do
      subject { Camera.new(200, 125, Math::PI / 2) }

      its(:pixel_size) { is_expected.to closely_eq(0.01) }
    end

    context 'portrait' do
      subject { Camera.new(125, 200, Math::PI / 2) }

      its(:pixel_size) { is_expected.to closely_eq(0.01) }
    end
  end
end