require 'world'

RSpec.describe World do
  describe '.new' do
    let(:w) { World.new }

    specify { expect(w.objects).to be_empty }
    specify { expect(w.light_source).to be_nil }
  end
end