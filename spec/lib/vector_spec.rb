RSpec.describe Vector do
  describe '#tuple' do
    subject { Vector.new(4, -4, 3).tuple }

    it { is_expected.to have_attributes(x: 4, y: -4, z: 3) }
    its(:w) { is_expected.to eq(0) }
  end

  describe '#+' do
    context 'plus vector' do
      let(:v1) { Vector.new(3, -2, 5) }
      let(:v2) { Vector.new(-2, 3, 1) }
      subject { v1 + v2 }

      it { is_expected.to be_an_instance_of(Vector) }
      it { is_expected.to eq(Vector.new(1, 1, 6)) }
    end
  end

  describe '#-' do
    context 'subtracting two vectors' do
      let(:v1) { Vector.new(3, 2, 1) }
      let(:v2) { Vector.new(5, 6, 7) }
      subject { v1 - v2 }

      it { is_expected.to be_an_instance_of(Vector) }
      it { is_expected.to eq(Vector.new(-2, -4, -6)) }
    end

    context 'subtracting a vector from the zero vector' do
      let(:zero) { Vector.new(0, 0, 0) }
      let(:v) { Vector.new(1, -2, 3) }
      subject { zero - v }

      it { is_expected.to eq(Vector.new(-1, 2, -3)) }
      it { is_expected.to eq(-v) }
    end

    context 'subtract a point' do
      let(:v) { Vector.new(5, 6, 7) }
      let(:p) { Point.new(3, 2, 1) }

      it 'errors' do
        expect { v - p }.to raise_error 'neither a point nor a vector' 
      end
    end
  end

  describe '#-@' do
    let(:v) { Vector.new(1, -2, 3) }
    subject { -v }

    it { is_expected.to eq(Vector.new(-1, 2, -3)) }
  end

  describe '#magnitude' do
    context 'x is 1' do
      subject { Vector.new(1, 0, 0).magnitude }

      it { is_expected.to eq(1) }
    end

    context 'y is 1' do
      subject { Vector.new(0, 1, 0).magnitude }

      it { is_expected.to eq(1) }
    end

    context 'z is 1' do
      subject { Vector.new(0, 0, 1).magnitude }

      it { is_expected.to eq(1) }
    end

    context 'x = 1, y = 2, z = 3' do
      subject { Vector.new(1, 2, 3).magnitude }

      it { is_expected.to eq(Math.sqrt(14)) }
    end

    context 'x = -1, y = -2, z = -3' do
      subject { Vector.new(-1, -2, -3).magnitude }

      it { is_expected.to eq(Math.sqrt(14)) }
    end
  end

  describe '#normalize' do
    context 'x = 4' do
      subject { Vector.new(4, 0, 0).normalize }

      its(:magnitude) { is_expected.to eq(1) }
      it { is_expected.to be_a_unit_vector }
      it { is_expected.to eq(Vector.new(1, 0, 0)) }
    end

    context 'x = 1, y = 2, z = 3' do
      subject { Vector.new(1, 2, 3).normalize }

      its(:magnitude) { is_expected.to eq(1) }
      it { is_expected.to be_a_unit_vector }
      it { is_expected.to eq(Vector.new(1 / Math.sqrt(14), 2 / Math.sqrt(14), 3 / Math.sqrt(14))) }
    end
  end

  describe '#dot' do
    let(:v1) { Vector.new(1, 2, 3) }
    let(:v2) { Vector.new(2, 3, 4) }

    it 'calculates it' do
      expect(Vector.dot(v1, v2)).to eq(20)
    end

    it 'is commutative' do
      expect(Vector.dot(v1, v2)).to eq(Vector.dot(v2, v1))
    end
  end

  describe '#cross' do
    let(:v1) { Vector.new(1, 2, 3) }
    let(:v2) { Vector.new(2, 3, 4) }

    it 'calculates it' do
      expect(Vector.cross(v1, v2)).to eq(Vector.new(-1, 2, -1))
      expect(Vector.cross(v2, v1)).to eq(Vector.new(1, -2, 1))
    end

    it 'is not commutative' do
      expect(Vector.cross(v1, v2)).not_to eq(Vector.cross(v2, v1))
    end
  end
end