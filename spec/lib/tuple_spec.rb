require 'tuple'
require 'point'
require 'vector'

RSpec.describe Tuple do
  context 'w = 1' do
    subject { Tuple.new(4.3, -4.2, 3.1, 1.0) }

    its(:x) { is_expected.to eq(4.3) }
    its(:y) { is_expected.to eq(-4.2) }
    its(:z) { is_expected.to eq(3.1) }

    it { is_expected.to be_a_point }
    it { is_expected.to_not be_a_vector }
  end

  context 'w = 0' do
    subject { Tuple.new(4.3, -4.2, 3.1, 0.0) }

    its(:x) { is_expected.to eq(4.3) }
    its(:y) { is_expected.to eq(-4.2) }
    its(:z) { is_expected.to eq(3.1) }

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
      it 'errors' do
        expect { Tuple.new(4.3, -4.2, 3.1, 'nan') }.to raise_error 'w must be a number'
      end
    end

    context '1.0' do
      it 'stores it as 1.0' do
        expect(Tuple.new(4, -4, 3, 1.0).w).to be_an_instance_of(Float) and eq(1.0)
      end
    end

    context '1' do
      it 'stores it as 1.0' do
        expect(Tuple.new(4, -4, 3, 1).w).to be_an_instance_of(Float) and eq(1.0)
      end
    end

    context '0.0' do
      it 'stores it as 0.0' do
        expect(Tuple.new(4, -4, 3, 0.0).w).to be_an_instance_of(Float) and eq(0.0)
      end
    end

    context '0' do
      it 'stores it as 0.0' do
        expect(Tuple.new(4, -4, 3, 0).w).to be_an_instance_of(Float) and eq(0.0)
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

  describe 'equality' do
    context 'w 1' do
      it 'is equal' do
        expect(Tuple.new(4, -4, 3, 1)).to eq(Tuple.new(4, -4, 3, 1.0))
      end
    end

    context 'w 0' do
      it 'is equal' do
        expect(Tuple.new(4, -4, 3, 0)).to eq(Tuple.new(4, -4, 3, 0.0))
      end
    end
  end

  describe '+' do
    it 'adds the individual components' do
      t1 = Tuple.new(3, -2, 5, 1)
      t2 = Tuple.new(-2, 3, 1, 0)

      expect(t1 + t2).to eq(Tuple.new(1, 1, 6, 1))
    end
  end

  describe '-' do
    it 'minuses the individual components' do
      t1 = Tuple.new(3, -2, 5, 1)
      t2 = Tuple.new(-2, 3, 1, 0)

      expect(t1 - t2).to eq(Tuple.new(5, -5, 4, 1))
    end

    context 'subtracting two vectors' do
      xit 'gives another vector' do
        v1 = Vector.new(3, 2, 1)
        v2 = Vector.new(5, 6, 7)

        expect(v1 - v2).to eq(Vector.new(-2, -4, -6))
      end

      xit 'negates a vector when subtracting a vector from the zero vector' do
        zero = Vector.new(0, 0, 0)
        v = Vector.new(1, -2, 3)

        expect(zero - v).to eq(Vector.new(-1, 2, -3))
      end
    end

    context 'subtract a point from a vector' do
      xit 'errors' do
        v = Vector.new(5, 6, 7)
        p = Point.new(3, 2, 1)
        
        expect { v - p }.to raise_error 'cannot subtract a point from a vector' 
      end
    end
  end

  describe 'negate unary minus' do
    context 'tuple' do
      it 'negates the components' do
        t = Tuple.new(1, -2, 3, -4)

        expect(-t).to eq(Tuple.new(-1, 2, -3, 4))
      end
    end

    # move
    context 'point' do
      xit 'errors' do
        t = Tuple.new(1, -2, 3, 1)

        expect { -t }.to raise_error 'cannot negate point'
      end
    end
  end

  describe '*' do
    context 'multiply by scalar' do
      it 'multiplies each component' do
        t = Tuple.new(1, -2, 3, -4)

        expect(t * 3.5).to eq(Tuple.new(3.5, -7, 10.5, -14))
      end
    end

    context 'multiply by a fraction' do
      it 'multiplies each component' do
        t = Tuple.new(1, -2, 3, -4)

        expect(t * 0.5).to eq(Tuple.new(0.5, -1, 1.5, -2))
      end
    end
  end

  describe '/' do
    it 'divides the components' do
      t = Tuple.new(1, -2, 3, -4)

      expect(t / 2).to eq(Tuple.new(0.5, -1, 1.5, -2))
    end
  end
end