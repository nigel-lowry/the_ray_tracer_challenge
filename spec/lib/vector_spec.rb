RSpec.describe Vector do
  describe '#tuple' do
    it 'has w = 0' do
      expect(Vector.new(4, -4, 3).tuple).to eq(Tuple.new(4, -4, 3, 0))
    end
  end

  describe '#+' do
    context 'vector plus vector' do
      let(:v1) { Vector.new(3, -2, 5) }
      let(:v2) { Vector.new(-2, 3, 1) }

      it 'is a vector' do
        expect(v1 + v2).to be_an_instance_of(Vector)
      end
    end
  end

  describe '#magnitude' do
    context 'x is 1' do
      let(:unit_vector) { Vector.new(1, 0, 0) }

      it 'has magnitude 1' do
        expect(unit_vector.magnitude).to eq(1)
      end
    end

    context 'y is 1' do
      let(:unit_vector) { Vector.new(0, 1, 0) }

      it 'has magnitude 1' do
        expect(unit_vector.magnitude).to eq(1)
      end
    end

    context 'z is 1' do
      let(:unit_vector) { Vector.new(0, 0, 1) }

      it 'has magnitude 1' do
        expect(unit_vector.magnitude).to eq(1)
      end
    end

    context 'x = 1, y = 2, z = 3' do
      let(:v) { Vector.new(1, 2, 3) }

      it 'is sqrt(14)' do
        expect(v.magnitude).to eq(Math.sqrt(14))
      end
    end

    context 'x = -1, y = -2, z = -3' do
      let(:v) { Vector.new(-1, -2, -3) }

      it 'is sqrt(14)' do
        expect(v.magnitude).to eq(Math.sqrt(14))
      end
    end
  end

  describe '#normalize' do
    context 'x = 4' do
      let(:v) { Vector.new(4, 0, 0) }

      it 'returns x = 1' do
        expect(v.normalize).to eq(Vector.new(1, 0, 0))
      end
    end

    context 'x = 1, y = 2, z = 3' do
      subject { Vector.new(1, 2, 3) }

      its(:normalize) { is_expected.to eq(Vector.new(1 / Math.sqrt(14), 2 / Math.sqrt(14), 3 / Math.sqrt(14))) }
      its('normalize.magnitude') { is_expected.to eq(1.0) }

      it 'is a unit vector' do
        expect(subject.normalize).to be_a_unit_vector
      end
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