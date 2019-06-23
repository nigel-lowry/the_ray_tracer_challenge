class World
  attr_reader :objects, :light

  def initialize objects=[], light=nil
    @objects, @light = objects, light
  end

  def self.default
    s1 = Sphere.new
    s2 = Sphere.new
    material = Material.new()

    material.color = Color.new(0.8, 1.0, 0.6)
    material.diffuse = 0.7
    material.specular = 0.2

    s1.material = material

    s2.transform = Transform.scaling(0.5, 0.5, 0.5)

    new([s1, s2], PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1)))
  end
end