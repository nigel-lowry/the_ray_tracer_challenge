require 'factory'

RSpec.describe Factory do
  describe '.create' do
    context 'point tuple' do
      let(:result) { Factory.create(Tuple.new(4.3, -4.2, 3.1, 1.0)) }

      it 'has x, y and z components' do
        expect(result).to have_attributes(x: 4.3, y: -4.2, z: 3.1)
      end

      it 'creates a point' do
        expect(result).to be_an_instance_of(Point)
      end
    end

    context 'vector tuple' do
      let(:result) { Factory.create(Tuple.new(4, -4, 3, 0.0)) }

      it 'has x, y and z components' do
        expect(result).to have_attributes(x: 4, y: -4, z: 3)
      end

      it 'creates a vector' do
        expect(result).to be_an_instance_of(Vector)
      end
    end
  end
end