require 'shape'

class TestShape < Shape
	attr_reader :saved_ray

	def initialize(**kwargs)
		super
	end

	def intersect(ray)
		@saved_ray = convert_to_object_space(ray)
	end

	def local_intersect(local_ray)
		intersect(local_ray)
	end

	def local_normal_at(point)
		Vector.new(point.x, point.y, point.z)
	end
end

RSpec.describe Shape do
	subject { TestShape.new }

	describe '.new' do
		it { is_expected.to have_attributes(transform: Transform::IDENTITY, material: Material::DEFAULT) }

		context 'with transform' do
			let(:translation) { Transform.translation(2, 3, 4) }

			subject { TestShape.new(transform: translation) }

			its(:transform) { is_expected.to eq(translation) }
		end

		context 'with material' do
			let(:material) { Material.new() }

			before { material.ambient = 1 }

			subject { TestShape.new(material: material) }

			its(:material) { is_expected.to eq(material) }

			specify { expect(material.ambient).to eq(1) }
		end
	end

	describe '#saved_ray' do
		context 'intersecting a scaled shape with a ray' do
			let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
			let(:s) { TestShape.new(transform: Transform.scaling(2, 2, 2)) }

			before { s.intersect(r) }

			specify { expect(s.saved_ray.origin).to eq(Point.new(0, 0, -2.5)) }
			specify { expect(s.saved_ray.direction).to eq(Vector.new(0, 0, 0.5)) }
		end

		context 'intersecting a translated shape with a ray' do
			let(:r) { Ray.new(Point.new(0, 0, -5), Vector.new(0, 0, 1)) }
			let(:s) { TestShape.new(transform: Transform.translation(5, 0, 0)) }

			before { s.intersect(r) }

			specify { expect(s.saved_ray.origin).to eq(Point.new(-5, 0, -5)) }
			specify { expect(s.saved_ray.direction).to eq(Vector.new(0, 0, 1)) }
		end
	end

	describe '#normal_at' do
		context 'translated shape' do
			let(:s) { TestShape.new(transform: Transform.translation(0, 1, 0)) }

			specify { expect(s.normal_at(Point.new(0, 1.70711, -0.70711))).to closely_eq(Vector.new(0, 0.70711, -0.70711)) }
		end

		context 'transformed shape' do
			let(:m) { Transform.scaling(1, 0.5, 1) * Transform.rotation_z(Math::PI / 5.0) }
			let(:s) { TestShape.new(transform: m) }

			specify { expect(s.normal_at(Point.new(0, Math.sqrt(2.0) / 2.0, -Math.sqrt(2.0) / 2.0))).to closely_eq(Vector.new(0, 0.97014, -0.24254)) }
		end
	end
end
