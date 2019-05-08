require 'color'

RSpec.describe Color do
  describe 'construction' do
    subject { Color.new(-0.5, 0.4, 1.7) }

    its(:red) { is_expected.to eq(-0.5) }
    its(:green) { is_expected.to eq(0.4) }
    its(:blue) { is_expected.to eq(1.7) }
  end

  describe '+' do
    it 'adds the components' do
      c1 = Color.new(0.9, 0.6, 0.75)
      c2 = Color.new(0.7, 0.1, 0.25)

      expect(c1 + c2).to eq(Color.new(1.6, 0.7, 1.0))
    end
  end

  describe '-' do
    it 'subtracts the components' do
      c1 = Color.new(0.9, 0.6, 0.75)
      c2 = Color.new(0.7, 0.1, 0.25)

      expect(c1 - c2).to eq(Color.new(0.2, 0.5, 0.5))
    end
  end

  describe '*' do
    context 'color by scalar' do
      it 'multiplies the components' do
        c = Color.new(0.2, 0.3, 0.4)

        expect(c * 2).to eq(Color.new(0.4, 0.6, 0.8))
      end
    end

    context 'color by color' do
      it 'multiplies each individual component' do
        c1 = Color.new(1, 0.2, 0.4)
        c2 = Color.new(0.9, 1, 0.1)

        expect(c1 * c2).to eq(Color.new(0.9, 0.2, 0.04))
      end
    end
  end
end