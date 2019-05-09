require 'point'

RSpec.describe Point do
  describe '#tuple' do
    it 'has w = 1' do
      expect(Point.new(4, -4, 3).tuple).to eq(Tuple.new(4, -4, 3, 1))
    end
  end
end