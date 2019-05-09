require 'factory'

RSpec.describe Factory do
  describe '.create' do
    context 'point tuple' do
      subject { Factory.create(Tuple.new(4.3, -4.2, 3.1, 1.0)) }

      it { is_expected.to be_an_instance_of(Point) }
      it { is_expected.to have_attributes(x: 4.3, y: -4.2, z: 3.1) }
    end

    context 'vector tuple' do
      subject { Factory.create(Tuple.new(4, -4, 3, 0.0)) }

      it { is_expected.to be_an_instance_of(Vector) }
      it { is_expected.to have_attributes(x: 4, y: -4, z: 3) }
    end
  end
end