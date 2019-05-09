require 'color'

RSpec.describe Color do
  describe 'construction' do
    let(:color) { Color.new(-0.5, 0.4, 1.7) }

    it 'stores the red, green, blue values' do
      expect(color).to have_attributes(red: -0.5, green: 0.4, blue: 1.7)
    end
  end

  describe '+' do
    it 'adds the components' do
      c1 = Color.new(0.9, 0.6, 0.75)
      c2 = Color.new(0.7, 0.1, 0.25)

      expect(c1 + c2).to closely_eq(Color.new(1.6, 0.7, 1.0))
    end
  end

  describe '-' do
    it 'subtracts the components' do
      c1 = Color.new(0.9, 0.6, 0.75)
      c2 = Color.new(0.7, 0.1, 0.25)

      expect(c1 - c2).to closely_eq(Color.new(0.2, 0.5, 0.5))
    end
  end

  describe '*' do
    context 'color by scalar' do
      it 'multiplies the components' do
        c = Color.new(0.2, 0.3, 0.4)

        expect(c * 2).to closely_eq(Color.new(0.4, 0.6, 0.8))
      end
    end

    context 'color by color' do
      it 'multiplies each individual component' do
        c1 = Color.new(1, 0.2, 0.4)
        c2 = Color.new(0.9, 1, 0.1)

        expect(c1 * c2).to closely_eq(Color.new(0.9, 0.2, 0.04))
      end
    end
  end
end