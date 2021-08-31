require 'sphere'
require 'shade_hit'
require 'point_light'

class World
  attr_accessor :objects, :light

  def initialize objects=nil, light=nil
    @objects, @light = Array.wrap(objects), light
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

  def intersect r
    intersection_arrays = @objects.collect { |object| object.intersect(r).intersections }
    Intersections.new(*intersection_arrays.flatten)
  end

  def color_at r
    hit = intersect(r).hit

    if hit.nil?
      Color::BLACK
    else
      ShadeHit.new(self, PrepareComputations.new(hit, r)).color
    end
  end

  def shadowed? point
    v = light.position - point
    h = intersect(Ray.new(point, v.normalize)).hit

    h.present? and h.t < v.magnitude
  end

  def reflected_color comps
    if comps.object.material.reflective.zero?
      Color::BLACK
    else
      reflect_ray = Ray.new(comps.over_point, comps.reflectv)
      color = color_at(reflect_ray)
      color * comps.object.material.reflective
    end
  end
end