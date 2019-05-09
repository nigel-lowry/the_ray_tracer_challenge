require 'color'

RSpec.describe Color do
  describe 'construction' do
    let(:color) { Color.new(-0.5, 0.4, 1.7) }

    it 'stores the red, green, blue values' do
      expect(color).to have_attributes(red: -0.5, green: 0.4, blue: 1.7)
    end
  end

  describe '+' do
    let(:c1) { Color.new(0.9, 0.6, 0.75) }
    let(:c2) { Color.new(0.7, 0.1, 0.25) }

    it 'adds the components' do
      expect(c1 + c2).to closely_eq(Color.new(1.6, 0.7, 1.0))
    end
  end

  describe '-' do
    let(:c1) { Color.new(0.9, 0.6, 0.75) }
    let(:c2) { Color.new(0.7, 0.1, 0.25) }

    it 'subtracts the components' do
      expect(c1 - c2).to closely_eq(Color.new(0.2, 0.5, 0.5))
    end
  end

  describe '*' do
    context 'color by scalar' do
      let(:c) { Color.new(0.2, 0.3, 0.4) }

      it 'multiplies the components' do
        expect(c * 2).to closely_eq(Color.new(0.4, 0.6, 0.8))
      end
    end

    context 'color by color' do
      let(:c1) { Color.new(1, 0.2, 0.4) }
      let(:c2) { Color.new(0.9, 1, 0.1) }

      it 'multiplies each individual component' do
        expect(c1 * c2).to closely_eq(Color.new(0.9, 0.2, 0.04))
      end
    end

    context 'color by string' do
      let(:c) { Color.new(1, 0.2, 0.4) }
      let(:v) { Vector.new(1, 2, 3) }

      it 'errors' do
        expect { c * v }.to raise_error 'unsupported operand'
      end
    end
  end
end