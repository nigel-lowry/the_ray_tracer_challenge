require 'vector'

RSpec.describe Vector do
  describe 'to_tuple' do
    it 'has w = 0' do
      expect(Vector.new(4, -4, 3).to_tuple).to eq(Tuple.new(4, -4, 3, 0))
    end
  end
end