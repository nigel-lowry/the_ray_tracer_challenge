require 'color'
require 'vector'

RSpec.describe Color do
  describe '.new' do
    subject { Color.new(-0.5, 0.4, 1.7) }

    it { is_expected.to have_attributes(red: -0.5, green: 0.4, blue: 1.7) }
    it { is_expected.to be_frozen }
  end

  describe '#+' do
    let(:c1) { Color.new(0.9, 0.6, 0.75) }
    let(:c2) { Color.new(0.7, 0.1, 0.25) }
    subject { c1 + c2 }

    it { is_expected.to eq(Color.new(1.6, 0.7, 1.0)) }
  end

  describe '#-' do
    let(:c1) { Color.new(0.9, 0.6, 0.75) }
    let(:c2) { Color.new(0.7, 0.1, 0.25) }
    subject { c1 - c2 }

    it { is_expected.to closely_eq(Color.new(0.2, 0.5, 0.5)) }
  end

  describe '#*' do
    context 'times scalar' do
      let(:c) { Color.new(0.2, 0.3, 0.4) }
      subject { c * 2 }

      it { is_expected.to eq(Color.new(0.4, 0.6, 0.8)) }
    end

    context 'times color' do
      let(:c1) { Color.new(1, 0.2, 0.4) }
      let(:c2) { Color.new(0.9, 1, 0.1) }
      subject { c1 * c2 }

      it { is_expected.to closely_eq(Color.new(0.9, 0.2, 0.04)) }
    end

    context 'times vector' do
      let(:c) { Color.new(1, 0.2, 0.4) }
      let(:v) { Vector.new(1, 2, 3) }

      specify { expect { c * v }.to raise_error 'unsupported operand' }
    end
  end

  describe '#to_s_ppm' do
    context 'c1' do
      let(:c) { Color.new(1.5, 0, 0) }

      specify { expect(c.to_s_ppm(255)).to eq('255 0 0') }
    end

    context 'c2' do
      let(:c) { Color.new(0, 0.5, 0) }

      specify { expect(c.to_s_ppm(255)).to eq('0 128 0') }
    end

    context 'c3' do
      let(:c) { Color.new(-0.5, 0, 1) }

      specify { expect(c.to_s_ppm(255)).to eq('0 0 255') }
    end
  end 
end