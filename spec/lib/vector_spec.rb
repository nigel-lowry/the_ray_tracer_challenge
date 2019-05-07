require 'vector'

RSpec.describe Vector do
  describe 'to_tuple' do
    it 'has w = 0' do
      expect(Vector.new(4, -4, 3).to_tuple).to eq(Tuple.new(4, -4, 3, 0))
    end
  end

  describe 'magnitude' do
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
end