require 'tuple'
require 'point'
require 'vector'

RSpec.describe Tuple do
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

  describe 'w' do
    context 'not a number' do
      specify { expect { Tuple.new(4.3, -4.2, 3.1, 'nan') }.to raise_error 'w must be a number' }
    end

    context '1.0' do
      specify { expect(Tuple.new(4, -4, 3, 1.0).w).to be_an_instance_of(Float) and eq(1.0) }
    end

    context '1' do
      specify { expect(Tuple.new(4, -4, 3, 1).w).to be_an_instance_of(Float) and eq(1.0) }
    end

    context '0.0' do
      specify { expect(Tuple.new(4, -4, 3, 0.0).w).to be_an_instance_of(Float) and eq(0.0) }
    end

    context '0' do
      specify { expect(Tuple.new(4, -4, 3, 0).w).to be_an_instance_of(Float) and eq(0.0) }
    end
  end

  describe 'x' do
    context 'not a number' do
      specify { expect { Tuple.new('nan', -4.2, 3.1, 1.0) }.to raise_error 'x must be a number' }
    end
  end

  describe 'y' do
    context 'not a number' do
      specify { expect { Tuple.new(4.3, 'nan', 3.1, 1.0) }.to raise_error 'y must be a number' }
    end
  end

  describe 'z' do
    context 'not a number' do
      specify { expect { Tuple.new(4.3, -4.2, 'nan', 1.0) }.to raise_error 'z must be a number' }
    end
  end

  describe '#eq' do
    context 'w 1 and 1.0' do
      let(:t1) { Tuple.new(4, -4, 3, 1) }
      let(:t2) { Tuple.new(4, -4, 3, 1.0) }

      it 'is equal' do
        expect(t1).to eq(t2)
      end
    end

    context 'w 0 and 0.0' do
      let(:t1) { Tuple.new(4, -4, 3, 0) }
      let(:t2) { Tuple.new(4, -4, 3, 0.0) }

      it 'is equal' do
        expect(t1).to eq(t2)
      end
    end
  end

  describe '#+' do
    let(:t1) { Tuple.new(3, -2, 5, 1) }
    let(:t2) { Tuple.new(-2, 3, 1, 0) }
    subject { t1 + t2 }

    it { is_expected.to eq(Tuple.new(1, 1, 6, 1)) }
  end

  describe '-' do
    let(:t1) { Tuple.new(3, -2, 5, 1) }
    let(:t2) { Tuple.new(-2, 3, 1, 0) }
    subject { t1 - t2 }

    it { is_expected.to eq(Tuple.new(5, -5, 4, 1)) }
  end

  describe '#-@' do
    let(:t) { Tuple.new(1, -2, 3, 0) }
    subject { -t }

    it { is_expected.to eq(Tuple.new(-1, 2, -3, 0)) }
  end

  describe '#*' do
    let(:t) { Tuple.new(1, -2, 3, -4) }

    context 'multiply by scalar' do
      subject { t * 3.5 }

      it { is_expected.to eq(Tuple.new(3.5, -7, 10.5, -14)) }
    end

    context 'multiply by a fraction' do
      subject { t * 0.5 }

      it { is_expected.to eq(Tuple.new(0.5, -1, 1.5, -2)) }
    end
  end

  describe '#/' do
    let(:t) { Tuple.new(1, -2, 3, -4) }

    context 'divide by scalar' do
      subject { t / 2 }

      it { is_expected.to eq(Tuple.new(0.5, -1, 1.5, -2)) }
    end
  end
end