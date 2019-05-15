require 'transform'

RSpec.describe Transform do
  context 'translation' do
    describe 'multiplying by a translation matrix' do
      let(:transform) { Transform.new_translation(5, -3, 2) }
      let(:p) { Point.new(-3, 4, 5) }

      specify { expect(transform * p).to eq(Point.new(2, 1, 7)) }
    end

    describe 'multiplying by the inverse of a translation matrix' do
      let(:transform) { Transform.new_translation(5, -3, 2) }
      let(:p) { Point.new(-3, 4, 5) }
      let(:inv) { transform.inverse }
      
      specify { expect(inv * p).to eq(Point.new(-8, 7, 3)) }
    end

    describe 'translation on a vector' do
      let(:transform) { Transform.new_translation(5, -3, 2) }
      let(:v) { Vector.new(-3, 4, 5) }

      it 'has no effect' do
        expect(transform * v).to eq(v)
      end
    end
  end

  context 'scaling' do
    describe 'scaling matrix applied to a point' do
      let(:transform) { Transform.new_scaling(2, 3, 4) }
      let(:p) { Point.new(-4, 6, 8) }

      specify { expect(transform * p).to eq(Point.new(-8, 18, 32)) }
    end

    describe 'scaling matrix applied to a vector' do
      let(:transform) { Transform.new_scaling(2, 3, 4) }
      let(:v) { Vector.new(-4, 6, 8) }

      specify { expect(transform * v).to eq(Vector.new(-8, 18, 32)) }
    end

    describe 'multiplying by the inverse of a scaling matrix' do
      let(:transform) { Transform.new_scaling(2, 3, 4) }
      let(:v) { Vector.new(-4, 6, 8) }
      let(:inv) { transform.inverse }

      specify { expect(inv * v).to eq(Vector.new(-2, 2, 2)) }
    end

    describe 'scaling by a negative value' do
      let(:transform) { Transform.new_scaling(-1, 1, 1) }
      let(:p) { Point.new(2, 3, 4) }

      it 'reflects' do
        expect(transform * p).to eq(Point.new(-2, 3, 4))
      end
    end
  end
end