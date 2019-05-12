require 'matrix'

RSpec.describe Matrix do
  describe '.new' do
    context '2x2' do
      let(:m) do
        Matrix.new  [-3,  5],
                    [ 1, -2]
      end

      specify { expect(m.get(0, 0)).to eq(-3) }
      specify { expect(m.get(0, 1)).to eq(5) }

      specify { expect(m.get(1, 0)).to eq(1) }
      specify { expect(m.get(1, 1)).to eq(-2) }
    end

    context '3x3' do
      let(:m) do
        Matrix.new  [-3,  5,  0],
                    [ 1, -2, -7],
                    [ 0,  1,  1]
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
    end

    context '4x4' do
      let(:m) do 
        Matrix.new  [   1,    2,    3, 4   ], 
                    [ 5.5,  6.5,  7.5, 8.5 ],
                    [   9,   10,   11, 12  ],
                    [13.5, 14.5, 15.5, 16.5]
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
    end
  end
end