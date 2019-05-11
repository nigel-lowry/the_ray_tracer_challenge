require 'canvas'

RSpec.describe Canvas do
  describe '.new' do
    subject { Canvas.new(10, 20) }

    it { is_expected.to have_attributes(width: 10, height: 20) }

    specify 'every pixel is black' do
      expect(subject.to_a).to all be_black
    end
  end
end