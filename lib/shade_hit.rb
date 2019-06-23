require 'world'
require 'prepare_computations'

class ShadeHit
  attr_reader :color

  def initialize world, comps
    color_for_each_light = world.lights.collect { |light| comps.object.material.lighting(light, comps.point, comps.eyev, comps.normalv) }
    @color = color_for_each_light.sum
  end
end