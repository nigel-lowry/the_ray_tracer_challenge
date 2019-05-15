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
end