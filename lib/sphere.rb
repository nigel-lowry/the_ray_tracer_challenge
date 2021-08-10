require 'ray'
require 'material'
require 'intersection'
require 'intersections'
require 'shape'

class Sphere < Shape
  attr_reader :radius
  attr_accessor :transform, :material

  def initialize
    @radius = 1
    @transform = Transform.new Matrix::IDENTITY_4X4
    @material = Material.new
  end

  def local_intersect ray
    dc = DiscriminantCalculator.new(ray)
    discriminant, a, b = dc.discriminant, dc.a, dc.b

    if discriminant < 0
      Intersections::NO_INTERSECTIONS
    else
      sqrt_of_discriminant = Math.sqrt discriminant
      two_a = 2 * a

      t1 = (-b - sqrt_of_discriminant) / two_a
      t2 = (-b + sqrt_of_discriminant) / two_a

      if t1 == t2
        Intersections.new Intersection.new(t1, self)
      else
        Intersections.new Intersection.new(t1, self), Intersection.new(t2, self)
      end
    end
  end

  def local_normal_at local_point
    object_normal = local_point - Point::ORIGIN
    Factory.create(Tuple.new_vector(object_normal.x, object_normal.y, object_normal.z)).normalize
  end

  def ==(other)
    self.class == other.class and self.radius == other.radius and self.transform == other.transform and self.material == other.material
  end
end

class DiscriminantCalculator
  attr_reader :sphere_to_ray, :a, :b, :c, :discriminant

  def initialize ray
    @sphere_to_ray = ray.origin - Point::ORIGIN

    @a = Vector.dot(ray.direction, ray.direction)
    @b = 2 * Vector.dot(ray.direction, sphere_to_ray)
    @c = Vector.dot(sphere_to_ray, sphere_to_ray) - 1

    @discriminant = @b * @b - 4 * @a * @c
  end
end