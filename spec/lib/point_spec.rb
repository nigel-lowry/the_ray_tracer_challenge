require 'point'

RSpec.describe Point do
  describe 'to_tuple' do
    it 'has w = 1' do
      expect(Point.new(4, -4, 3).to_tuple).to eq(Tuple.new(4, -4, 3, 1))
    end
  end
end