require 'point'

RSpec.describe Point do
  describe '#tuple' do
    it 'has w = 1' do
      expect(Point.new(4, -4, 3).tuple).to eq(Tuple.new(4, -4, 3, 1))
    end
  end

  describe '#+' do
    context 'point plus vector' do
      let(:p) { Point.new(3, -2, 5) } 
      let(:v) { Vector.new(-2, 3, 1) }

      it 'is a point' do
        expect(p + v).to be_an_instance_of(Point)
      end
    end

    context 'point plus point' do
      let(:p1) { Point.new(3, -2, 5) }
      let(:p2) { Point.new(-2, 3, 1) }

      it 'errors' do
        expect { p1 + p2 }.to raise_error 'neither a point nor a vector'
      end
    end
  end
end