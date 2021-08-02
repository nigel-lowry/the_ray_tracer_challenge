require 'camera'

RSpec.describe Camera do
  describe '.new' do
    let(:hsize) { 160 }
    let(:vsize) { 120 }
    let(:field_of_view) { Math::PI / 2 }

    subject { Camera.new(hsize, vsize, field_of_view) }

    it { is_expected.to have_attributes(hsize: 160, vsize: 120, field_of_view: Math::PI / 2) }
    its(:transform) { is_expected.to eq(Transform::IDENTITY) }
    it { is_expected.to be_frozen }

    context 'with transform' do
      let(:transform) { Transform.rotation_y(Math::PI / 4) * Transform.translation(0, -2, 5) }
      subject { Camera.new(201, 101, Math::PI / 2, transform) }

      it { is_expected.to have_attributes(hsize: 201, vsize: 101, field_of_view: Math::PI / 2, transform: transform) }
    end
  end

  describe '#pixel_size' do
    context 'landscape' do
      subject { Camera.new(200, 125, Math::PI / 2) }

      its(:pixel_size) { is_expected.to closely_eq(0.01) }
    end

    context 'portrait' do
      subject { Camera.new(125, 200, Math::PI / 2) }

      its(:pixel_size) { is_expected.to closely_eq(0.01) }
    end
  end

  describe '#ray_for_pixel' do
    context 'centre of canvas' do
      let(:c) { Camera.new(201, 101, Math::PI / 2) }
      subject { c.ray_for_pixel(100, 50) }

      its(:origin) { is_expected.to eq(Point::ORIGIN) }
      its(:direction) { is_expected.to closely_eq(Vector.new(0, 0, -1)) }
    end

    context 'corner of canvas' do
      let(:c) { Camera.new(201, 101, Math::PI / 2) }
      subject { c.ray_for_pixel(0, 0) }

      its(:origin) { is_expected.to eq(Point::ORIGIN) }
      its(:direction) { is_expected.to closely_eq(Vector.new(0.66519, 0.33259, -0.66851)) }
    end

    context 'camera transformed' do
      let(:transform) { Transform.rotation_y(Math::PI / 4) * Transform.translation(0, -2, 5) }
      let(:c) { Camera.new(201, 101, Math::PI / 2, transform) }

      subject { c.ray_for_pixel(100, 50) }

      its(:origin) { is_expected.to eq(Point.new(0, 2, -5)) }
      its(:direction) { is_expected.to closely_eq(Vector.new(Math.sqrt(2) / 2, 0, -Math.sqrt(2) / 2)) }
    end
  end

  describe '#render' do
    let(:w) { World.default }
    let(:from) { Point.new(0, 0, -5) }
    let(:to) { Point::ORIGIN }
    let(:up) { Vector.new(0, 1, 0) }
    let(:transform) { Transformations.view_transform(from, to, up) }
    let(:c) { Camera.new(11, 11, Math::PI / 2, transform) }

    let(:image) { c.render(w) }

    specify { expect(image.pixel_at(5, 5)).to closely_eq(Color.new(0.38066, 0.47583, 0.2855)) }
  end
end