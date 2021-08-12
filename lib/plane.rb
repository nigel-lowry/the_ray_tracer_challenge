require 'shape'
require 'vector'
require 'intersections'
require 'intersection'

class Plane < Shape
	THE_NORMAL = Vector.new(0, 1, 0)

	def local_normal_at(point)
		THE_NORMAL
	end

	def local_intersect(ray)
		if ray.direction.y.abs < EPSILON
			Intersections::NO_INTERSECTIONS
		else
			t = -ray.origin.y / ray.direction.y
			Intersections.new Intersection.new(t, self)
		end
	end
end