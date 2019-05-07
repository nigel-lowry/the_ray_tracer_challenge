require 'tuple'

RSpec.describe Tuple do
  context 'point' do
    subject { Tuple.new(4.3, -4.2, 3.1, 1.0) }

    its(:x) { is_expected.to eq(4.3) }
    its(:y) { is_expected.to eq(-4.2) }
    its(:z) { is_expected.to eq(3.1) }

    it { is_expected.to be_a_point }
    it { is_expected.to_not be_a_vector }
  end

  context 'vector' do
    subject { Tuple.new(4.3, -4.2, 3.1, 0.0) }

    its(:x) { is_expected.to eq(4.3) }
    its(:y) { is_expected.to eq(-4.2) }
    its(:z) { is_expected.to eq(3.1) }

    it { is_expected.to be_a_vector }
    it { is_expected.to_not be_a_point }
  end

  describe 'w' do
    context 'invalid values' do
      it 'errors' do
        invalid_w_values = [-0.1, 0.1, 0.9, 1.1]

        invalid_w_values.each do |value|
          expect { Tuple.new(4.3, -4.2, 3.1, value) }.to raise_error 'w must be 0.0 or 1.0'
        end
      end
    end
  end

  describe 'x' do
    context 'not a number' do
      it 'errors' do
        expect { Tuple.new('nan', -4.2, 3.1, 1.0) }.to raise_error 'x must be a number'
      end
    end
  end

  describe 'y' do
    context 'not a number' do
      it 'errors' do
        expect { Tuple.new(4.3, 'nan', 3.1, 1.0) }.to raise_error 'y must be a number'
      end
    end
  end

  describe 'z' do
    context 'not a number' do
      it 'errors' do
        expect { Tuple.new(4.3, -4.2, 'nan', 1.0) }.to raise_error 'z must be a number'
      end
    end
  end
end