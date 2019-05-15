require 'tuple'

RSpec.describe Tuple do

  describe 'x' do
    specify { expect { Tuple.new('nan', -4.2, 3.1, 1.0) }.to raise_error 'x must be a number' }
  end

  describe 'y' do
    specify { expect { Tuple.new(4.3, 'nan', 3.1, 1.0) }.to raise_error 'y must be a number' }
  end

  describe 'z' do
    specify { expect { Tuple.new(4.3, -4.2, 'nan', 1.0) }.to raise_error 'z must be a number' }
  end

  describe 'w' do
    specify { expect { Tuple.new(4.3, -4.2, 3.1, 'nan') }.to raise_error 'w must be a number' }
    
    specify { expect(Tuple.new(4, -4, 3, 1.0).w).to be_an_instance_of(Float) and eq(1.0) }
    specify { expect(Tuple.new(4, -4, 3, 1).w).to be_an_instance_of(Float) and eq(1.0) }

    specify { expect(Tuple.new(4, -4, 3, 0.0).w).to be_an_instance_of(Float) and eq(0.0) }
    specify { expect(Tuple.new(4, -4, 3, 0).w).to be_an_instance_of(Float) and eq(0.0) }

    context 'w = 1' do
      subject { Tuple.new(4.3, -4.2, 3.1, 1.0) }

      it { is_expected.to have_attributes(x: 4.3, y: -4.2, z: 3.1, w: 1.0) }
      it { is_expected.to be_a_point }
      it { is_expected.to_not be_a_vector }
    end

    context 'w = 0' do
      subject { Tuple.new(4.3, -4.2, 3.1, 0.0) }

      it { is_expected.to have_attributes(x: 4.3, y: -4.2, z: 3.1, w: 0.0) }
      it { is_expected.to be_a_vector }
      it { is_expected.to_not be_a_point }
    end

    context 'w = 2' do
      subject { Tuple.new(4.3, -4.2, 3.1, 2.0) }

      it { is_expected.to_not be_a_vector }
      it { is_expected.to_not be_a_point }
      it { is_expected.to be_neither_a_point_nor_a_vector }
    end
  end

  describe '#eq' do
    context 'w 1 and 1.0' do
      let(:t1) { Tuple.new(4, -4, 3, 1) }
      let(:t2) { Tuple.new(4, -4, 3, 1.0) }

      specify { expect(t1).to eq(t2) }
      specify { expect(t2).to eq(t1) }
    end

    context 'w 0 and 0.0' do
      let(:t1) { Tuple.new(4, -4, 3, 0) }
      let(:t2) { Tuple.new(4, -4, 3, 0.0) }

      specify { expect(t1).to eq(t2) }
      specify { expect(t2).to eq(t1) }
    end
  end

  describe '#+' do
    let(:t1) { Tuple.new(3, -2, 5, 1) }
    let(:t2) { Tuple.new(-2, 3, 1, 0) }

    specify { expect(t1 + t2).to eq(Tuple.new(1, 1, 6, 1)) }
  end

  describe '-' do
    let(:t1) { Tuple.new(3, -2, 5, 1) }
    let(:t2) { Tuple.new(-2, 3, 1, 0) }

    specify { expect(t1 - t2).to eq(Tuple.new(5, -5, 4, 1)) }
  end

  describe '#-@' do
    let(:t) { Tuple.new(1, -2, 3, -4) }

    specify { expect(-t).to eq(Tuple.new(-1, 2, -3, 4)) }
  end

  describe '#*' do
    let(:t) { Tuple.new(1, -2, 3, -4) }

    specify { expect(t * 3.5).to eq(Tuple.new(3.5, -7, 10.5, -14)) }
    specify { expect(t * 0.5).to eq(Tuple.new(0.5, -1, 1.5, -2)) }
  end

  describe '#/' do
    let(:t) { Tuple.new(1, -2, 3, -4) }

    specify { expect(t / 2).to eq(Tuple.new(0.5, -1, 1.5, -2)) }
  end
end