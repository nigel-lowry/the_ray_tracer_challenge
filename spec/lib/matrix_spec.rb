require 'matrix'

RSpec.describe Matrix do
  describe '.new' do
    context '2x2' do
      let(:m) do
        Matrix.new [[-3,  5],
                    [ 1, -2]]
      end

      specify { expect(m.get(0, 0)).to eq(-3) }
      specify { expect(m.get(0, 1)).to eq(5) }

      specify { expect(m.get(1, 0)).to eq(1) }
      specify { expect(m.get(1, 1)).to eq(-2) }

      specify { expect(m.size).to eq(2) }
    end

    context '3x3' do
      let(:m) do
        Matrix.new [[-3,  5,  0],
                    [ 1, -2, -7],
                    [ 0,  1,  1]]
      end

      specify { expect(m.get(0, 0)).to eq(-3) }
      specify { expect(m.get(0, 1)).to eq(5) }
      specify { expect(m.get(0, 2)).to eq(0) }

      specify { expect(m.get(1, 0)).to eq(1) }
      specify { expect(m.get(1, 1)).to eq(-2) }
      specify { expect(m.get(1, 2)).to eq(-7) }

      specify { expect(m.get(2, 0)).to eq(0) }
      specify { expect(m.get(2, 1)).to eq(1) }
      specify { expect(m.get(2, 2)).to eq(1) }

      specify { expect(m.size).to eq(3) }
    end

    context '4x4' do
      let(:m) do 
        Matrix.new [[   1,    2,    3, 4   ], 
                    [ 5.5,  6.5,  7.5, 8.5 ],
                    [   9,   10,   11, 12  ],
                    [13.5, 14.5, 15.5, 16.5]]
      end

      specify { expect(m.get(0, 0)).to eq(1) }
      specify { expect(m.get(0, 1)).to eq(2) }
      specify { expect(m.get(0, 2)).to eq(3) }
      specify { expect(m.get(0, 3)).to eq(4) }

      specify { expect(m.get(1, 0)).to eq(5.5) }
      specify { expect(m.get(1, 1)).to eq(6.5) }
      specify { expect(m.get(1, 2)).to eq(7.5) }
      specify { expect(m.get(1, 3)).to eq(8.5) }

      specify { expect(m.get(2, 0)).to eq(9) }
      specify { expect(m.get(2, 1)).to eq(10) }
      specify { expect(m.get(2, 2)).to eq(11) }
      specify { expect(m.get(2, 3)).to eq(12) }

      specify { expect(m.get(3, 0)).to eq(13.5) }
      specify { expect(m.get(3, 1)).to eq(14.5) }
      specify { expect(m.get(3, 2)).to eq(15.5) }
      specify { expect(m.get(3, 3)).to eq(16.5) }

      specify { expect(m.size).to eq(4) }
    end
  end

  describe '#eq' do
    context 'identical' do
      let(:a) do 
        Matrix.new [[1, 2, 3, 4], 
                    [5, 6, 7, 8],
                    [9, 8, 7, 6],
                    [5, 4, 3, 2]]
      end

      let(:b) do 
        Matrix.new [[1, 2, 3, 4], 
                    [5, 6, 7, 8],
                    [9, 8, 7, 6],
                    [5, 4, 3, 2]]
      end

      specify { expect(a).to eq(b) }
      specify { expect(b).to eq(a) }
    end

    context 'different' do
      let(:a) do 
        Matrix.new [[1, 2, 3, 4], 
                    [5, 6, 7, 8],
                    [9, 8, 7, 6],
                    [5, 4, 3, 2]]
      end

      let(:b) do 
        Matrix.new [[2, 3, 4, 5], 
                    [6, 7, 8, 9],
                    [8, 7, 6, 5],
                    [4, 3, 2, 1]]
      end

      specify { expect(a).to_not eq(b) }
      specify { expect(b).to_not eq(a) }
    end
  end

  describe '#*' do
    context 'multiply by matrix' do
      let(:a) do 
        Matrix.new [[1, 2, 3, 4], 
                    [5, 6, 7, 8],
                    [9, 8, 7, 6],
                    [5, 4, 3, 2]]
      end

      let(:b) do 
        Matrix.new [[-2, 1, 2,  3], 
                    [ 3, 2, 1, -1],
                    [ 4, 3, 6,  5],
                    [ 1, 2, 7,  8]]
      end

      specify { expect(a * b).to eq(
        Matrix.new [[20, 22,  50,  48], 
                    [44, 54, 114, 108],
                    [40, 58, 110, 102],
                    [16, 26,  46,  42]]
      ) }
    end

    context 'multiply by identity matrix' do
      let(:a) do 
        Matrix.new [[0, 1,  2,  4], 
                    [1, 2,  4,  8],
                    [2, 4,  8, 16],
                    [4, 8, 16, 32]]
      end

      specify { expect(a * Matrix::IDENTITY_4X4).to eq(a) }
    end

    context 'multiply by tuple' do
      let(:a) do 
        Matrix.new [[1, 2, 3, 4], 
                    [2, 4, 4, 2],
                    [8, 6, 4, 1],
                    [0, 0, 0, 1]]
      end

      let(:b) { Tuple.new(1, 2, 3, 1) }

      specify { expect(a * b).to eq(Tuple.new(18, 24, 33, 1)) }
    end

    context 'multiple identity matrix by tuple' do
      let(:a) { Tuple.new(1, 2, 3, 4) }

      specify { expect(Matrix::IDENTITY_4X4 * a).to eq(a) }
    end
  end

  describe '#transpose' do
    context 'transpose a matrix' do
      let(:a) do 
        Matrix.new [[0, 9, 3, 0], 
                    [9, 8, 0, 8],
                    [1, 8, 5, 3],
                    [0, 0, 5, 8]]
      end

      specify { expect(a.transpose).to eq(
        Matrix.new [[0, 9, 1, 0], 
                    [9, 8, 8, 0],
                    [3, 0, 5, 5],
                    [0, 8, 3, 8]]
      ) }
    end

    context 'transpose the identity matrix' do
      specify { expect(Matrix::IDENTITY_4X4.transpose).to eq(Matrix::IDENTITY_4X4) }
    end
  end

  describe '#determinant' do
    context '2x2' do
      let(:a) do
        Matrix.new [[ 1, 5],
                    [-3, 2]]
      end

      specify { expect(a.determinant).to eq(17) }
    end

    context '3x3' do
      let(:a) do
        Matrix.new [[ 1, 2,  6],
                    [-5, 8, -4],
                    [ 2, 6,  4]]
      end

      specify { expect(a.cofactor(0, 0)).to eq(56) }
      specify { expect(a.cofactor(0, 1)).to eq(12) }
      specify { expect(a.cofactor(0, 2)).to eq(-46) }
      specify { expect(a.determinant).to eq(-196) }
    end

    context '4x4' do
      let(:a) do
        Matrix.new [[-2, -8,  3,  5],
                    [-3,  1,  7,  3],
                    [ 1,  2, -9,  6],
                    [-6,  7,  7, -9]]
      end

      specify { expect(a.cofactor(0, 0)).to eq(690) }
      specify { expect(a.cofactor(0, 1)).to eq(447) }
      specify { expect(a.cofactor(0, 2)).to eq(210) }
      specify { expect(a.cofactor(0, 3)).to eq(51) }
      specify { expect(a.determinant).to eq(-4071) }
    end
  end

  describe '#submatrix' do
    context '3x3' do
      let(:a) do
        Matrix.new [[ 1, 5,  0],
                    [-3, 2,  7],
                    [ 0, 6, -3]]
      end

      specify { expect(a.submatrix(0, 2)).to eq(
        Matrix.new [[-3, 2],
                    [ 0, 6]]
      ) }

      it 'keeps everything the same' do
        m = Matrix.new [[ 1, 5,  0],
                    [-3, 2,  7],
                    [ 0, 6, -3]]

        s = a.submatrix(0, 2)
        
        expect(m.data).to eq([[ 1, 5,  0],
                    [-3, 2,  7],
                    [ 0, 6, -3]])   
        expect(m).to eq(Matrix.new [[ 1, 5,  0],
                    [-3, 2,  7],
                    [ 0, 6, -3]])

        expect(s.data).to eq([[-3, 2],
                    [ 0, 6]])      
      end
    end

    context '4x4' do
      let(:a) do
        Matrix.new [[-6, 1,  1, 6],
                    [-8, 5,  8, 6],
                    [-1, 0,  8, 2],
                    [-7, 1, -1, 1]]
      end

      specify { expect(a.submatrix(2, 1)).to eq(
        Matrix.new [[-6,  1, 6],
                    [-8,  8, 6],
                    [-7, -1, 1]]
      ) }
    end
  end

  describe '#minor' do
    let(:a) do
      Matrix.new [[3,  5,  0],
                  [2, -1, -7],
                  [6, -1,  5]]
    end

    let(:b) { a.submatrix(1, 0) }

    specify { expect(b.determinant).to eq(25) }
    specify { expect(a.minor(1, 0)).to eq(25) }
    specify { expect(b.determinant).to eq(a.minor(1, 0)) }
  end

  describe '#cofactor' do
    let(:a) do
      Matrix.new [[3,  5,  0],
                  [2, -1, -7],
                  [6, -1,  5]]
    end

    specify { expect(a.minor(0, 0)).to eq(-12) }
    specify { expect(a.cofactor(0, 0)).to eq(-12) }
    specify { expect(a.minor(1, 0)).to eq(25) }
    specify { expect(a.cofactor(1, 0)).to eq(-25) }
  end
end