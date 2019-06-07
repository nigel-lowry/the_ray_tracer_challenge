class Sphere
  attr_reader :radius

  def initialize
    @radius = 1
  end

  def intersect ray
    dc = DiscriminantCalculator.new(self, ray)
    discriminant, a, b = dc.discriminant, dc.a, dc.b

    if discriminant < 0
      []
    else
      t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
      t2 = (-b + Math.sqrt(discriminant)) / (2 * a)

      [t1, t2]
    end
  end
end

class DiscriminantCalculator
  attr_reader :sphere_to_ray, :a, :b, :c, :discriminant

  def initialize sphere, ray
    @sphere_to_ray = ray.origin - Point.new(0, 0, 0) # const

    @a = Vector.dot(ray.direction, ray.direction)
    @b = 2 * Vector.dot(ray.direction, sphere_to_ray)
    @c = Vector.dot(sphere_to_ray, sphere_to_ray) - 1

    @discriminant = @b * @b - 4 * @a * @c
  end
end