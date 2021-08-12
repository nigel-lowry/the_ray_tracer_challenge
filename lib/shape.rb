require 'transform'
require 'material'
require 'ray'
require 'vector'

class Shape
	attr_accessor :transform, :material

	def initialize(transform: Transform::IDENTITY, material: Material::DEFAULT)
		@transform, @material = transform, material
	end

	def intersect(ray)
		local_ray = convert_to_object_space(ray)
		local_intersect(local_ray)
	end

	def normal_at(point)
    transform_inverse = transform.inverse
		local_point = transform_inverse * point
		local_normal = local_normal_at(local_point)
		world_normal = transform_inverse.transformation_matrix.transpose * local_normal
		Vector.new(world_normal.x, world_normal.y, world_normal.z).normalize
	end

	private

	def convert_to_object_space(ray)
		ray.transform(transform.inverse)
	end
end