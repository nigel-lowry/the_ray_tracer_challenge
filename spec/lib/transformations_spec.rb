require 'transformations'

RSpec.describe Transformations do
  describe '#view_transform' do
    context 'default orientation' do
      let(:from) { Point.new(0, 0, 0) }
      let(:to) { Point.new(0, 0, -1) }
      let(:up) { Vector.new(0, 1, 0) }

      specify { expect(Transformations.view_transform(from, to, up)).to eq(Transform.new Matrix::IDENTITY_4X4) }
    end

    context 'looking in the positive z direction' do
      let(:from) { Point.new(0, 0, 0) }
      let(:to) { Point.new(0, 0, 1) }
      let(:up) { Vector.new(0, 1, 0) }

      specify { expect(Transformations.view_transform(from, to, up)).to eq(Transform.scaling(-1, 1, -1)) }
    end

    context 'translation' do
      let(:from) { Point.new(0, 0, 8) }
      let(:to) { Point.new(0, 0, 0) }
      let(:up) { Vector.new(0, 1, 0) }

      specify { expect(Transformations.view_transform(from, to, up)).to eq(Transform.translation(0, 0, -8)) }
    end

    context 'arbitrary direction' do
      let(:from) { Point.new(1, 3, 2) }
      let(:to) { Point.new(4, -2, 8) }
      let(:up) { Vector.new(1, 1, 0) }

      specify { expect(Transformations.view_transform(from, to, up).transformation_matrix).to closely_eq(
        Matrix.new [[-0.50709, 0.50709,  0.67612, -2.36643],
                    [ 0.76772, 0.60609,  0.12122, -2.82843],
                    [-0.35857, 0.59761, -0.71714,  0.00000],
                    [ 0.00000, 0.00000,  0.00000,  1.00000]]
      ) }
    end
  end
end