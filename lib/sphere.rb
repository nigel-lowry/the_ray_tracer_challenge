require 'ray'
require 'material'
require 'intersection'
require 'intersections'

class Sphere
  attr_reader :radius
  attr_accessor :transform, :material

  def initialize
    @radius = 1
    @transform = Transform.new Matrix::IDENTITY_4X4
    @material = Material.new
  end

  def intersect ray
    dc = DiscriminantCalculator.new(self, ray.transform(self.transform.inverse))
    discriminant, a, b = dc.discriminant, dc.a, dc.b

    if discriminant < 0
      Intersections::NO_INTERSECTIONS
    else
      sqrt_of_discriminant = Math.sqrt discriminant
      two_a = 2 * a

      t1 = (-b - sqrt_of_discriminant) / two_a
      t2 = (-b + sqrt_of_discriminant) / two_a

      Intersections.new Intersection.new(t1, self), Intersection.new(t2, self)
    end
  end

  def normal_at world_point
    transform_inverse = transform.inverse
    object_point = transform_inverse * world_point
    object_normal = object_point - Point::ORIGIN
    world_normal = transform_inverse.transformation_matrix.transpose * object_normal
    Factory.create(Tuple.new_vector(world_normal.x, world_normal.y, world_normal.z)).normalize
  end

  def ==(other)
    self.class == other.class and self.radius == other.radius and self.transform == other.transform and self.material == other.material
  end
end

class DiscriminantCalculator
  attr_reader :sphere_to_ray, :a, :b, :c, :discriminant

  def initialize sphere, ray
    @sphere_to_ray = ray.origin - Point::ORIGIN

    @a = Vector.dot(ray.direction, ray.direction)
    @b = 2 * Vector.dot(ray.direction, sphere_to_ray)
    @c = Vector.dot(sphere_to_ray, sphere_to_ray) - 1

    @discriminant = @b * @b - 4 * @a * @c
  end
end