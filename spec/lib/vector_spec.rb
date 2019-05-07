require 'vector'

RSpec.describe Vector do
  describe '#to_tuple' do
    it 'has w = 0' do
      expect(Vector.new(4, -4, 3).to_tuple).to eq(Tuple.new(4, -4, 3, 0))
    end
  end

  describe '#magnitude' do
    context 'x is 1' do
      it 'is 1' do
        v = Vector.new(1, 0, 0)

        expect(v.magnitude).to eq(1)
      end
    end

    context 'y is 1' do
      it 'is 1' do
        v = Vector.new(0, 1, 0)

        expect(v.magnitude).to eq(1)
      end
    end

    context 'z is 1' do
      it 'is 1' do
        v = Vector.new(0, 0, 1)

        expect(v.magnitude).to eq(1)
      end
    end

    context 'x = 1, y = 2, z = 3' do
      it 'is sqrt(14)' do
        v = Vector.new(1, 2, 3)

        expect(v.magnitude).to eq(Math.sqrt(14))
      end
    end

    context 'x = -1, y = -2, z = -3' do
      it 'is sqrt(14)' do
        v = Vector.new(-1, -2, -3)

        expect(v.magnitude).to eq(Math.sqrt(14))
      end
    end
  end

  describe '#normalize' do
    context 'x = 4' do
      it 'returns x = 1' do
        v = Vector.new(4, 0, 0)

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
    it 'calculates it' do
      v1 = Vector.new(1, 2, 3)
      v2 = Vector.new(2, 3, 4)

      expect(Vector.dot(v1, v2)).to eq(20)
    end
  end
end