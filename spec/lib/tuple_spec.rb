require 'tuple'

RSpec.describe Tuple do
  context 'point' do
  	let(:tuple) { Tuple.new(4.3, -4.2, 3.1, 1.0) }

    specify 'x is 4.3' do
      expect(tuple.x).to eq(4.3)
    end

    specify 'y is -4.2' do
      expect(tuple.y).to eq(-4.2)
    end

    specify 'z is 3.1' do
      expect(tuple.z).to eq(3.1)
    end

    it 'is a point' do
      expect(tuple).to be_point
    end

    it 'is not a vector' do
      expect(tuple).not_to be_vector
    end
  end

  context 'vector' do
    let(:tuple) { Tuple.new(4.3, -4.2, 3.1, 0.0) }

    specify 'x is 4.3' do
      expect(tuple.x).to eq(4.3)
    end

    specify 'y is -4.2' do
      expect(tuple.y).to eq(-4.2)
    end

    specify 'z is 3.1' do
      expect(tuple.z).to eq(3.1)
    end

    it 'is a vector' do
      expect(tuple).to be_vector
    end

    it 'is not a point' do
      expect(tuple).not_to be_point
    end
  end
end