require 'active_support/core_ext/enumerable'
require 'material'
require 'sphere'

class World
  attr_accessor :objects, :lights

  def initialize objects=nil, lights=nil
    @objects, @lights = Array.wrap(objects), Array.wrap(lights)
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

  def light=(other_light)
    @lights = Array.wrap other_light
  end

  def light
    raise 'multiple lights' if @lights.many?
    @lights.first
  end
end