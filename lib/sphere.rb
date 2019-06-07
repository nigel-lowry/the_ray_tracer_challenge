class Sphere
  attr_reader :radius

  def initialize
    @radius = 1
  end

  def intersect ray
    if discriminant(ray) < 0
      []
    else
      dc = DiscriminantCalculator.new(self, ray)
      a, b = dc.a, dc.b

      t1 = (-b - Math.sqrt(discriminant(ray))) / (2 * a)
      t2 = (-b + Math.sqrt(discriminant(ray))) / (2 * a)

      [t1, t2]
    end
  end

private

  def discriminant ray
    dc = DiscriminantCalculator.new(self, ray)
    sphere_to_ray, a, b, c = dc.sphere_to_ray, dc.a, dc.b, dc.c

    b * b - 4 * a * c
  end
end

class DiscriminantCalculator
  attr_reader :sphere_to_ray, :a, :b, :c

  def initialize sphere, ray
    @sphere_to_ray = ray.origin - Point.new(0, 0, 0) # const

    @a = Vector.dot(ray.direction, ray.direction)
    @b = 2 * Vector.dot(ray.direction, sphere_to_ray)
    @c = Vector.dot(sphere_to_ray, sphere_to_ray) - 1
  end
end