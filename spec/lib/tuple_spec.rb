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

    context 'point plus vector' do
      it 'is a point' do
        t1 = Tuple.new(3, -2, 5, 1)
        t2 = Tuple.new(-2, 3, 1, 0)

        expect(t1 + t2).to be_a_point
      end
    end

    context 'vector plus vector' do
      it 'is a vector' do
        t1 = Tuple.new(3, -2, 5, 0)
        t2 = Tuple.new(-2, 3, 1, 0)

        expect(t1 + t2).to be_a_vector
      end
    end

    context 'point plus point' do
      it 'errors' do
        t1 = Tuple.new(3, -2, 5, 1)
        t2 = Tuple.new(-2, 3, 1, 1)

        expect { t1 + t2 }.to raise_error 'cannot add two points'
      end
    end
  end

  describe '-' do
    context 'subtracting two points' do
      it 'minuses the components' do
        p1 = Point.new(3, 2, 1)
        p2 = Point.new(5, 6, 7)

        expect(p1 - p2).to eq(Vector.new(-2, -4, -6))
      end
    end

    context 'subtracting a vector from a point' do
      it 'minuses' do
        p = Point.new(3, 2, 1)
        v = Vector.new(5, 6, 7)

        expect(p - v).to eq(Point.new(-2, -4, -6))
      end
    end

    context 'subtracting two vectors' do
      it 'gives another vector' do
        v1 = Vector.new(3, 2, 1)
        v2 = Vector.new(5, 6, 7)

        expect(v1 - v2).to eq(Vector.new(-2, -4, -6))
      end

      it 'negates a vector when subtracting a vector from the zero vector' do
        zero = Vector.new(0, 0, 0)
        v = Vector.new(1, -2, 3)

        expect(zero - v).to eq(Vector.new(-1, 2, -3))
      end
    end

    context 'subtract a point from a vector' do
      it 'errors' do
        v = Vector.new(5, 6, 7)
        p = Point.new(3, 2, 1)
        
        expect { v - p }.to raise_error 'cannot subtract a point from a vector' 
      end
    end
  end
end