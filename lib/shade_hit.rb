require 'world'
require 'prepare_computations'

class ShadeHit
  attr_reader :color

  def initialize world, comps
    shadowed = world.shadowed? comps.over_point

    color_for_each_light = world.lights.collect { |light| comps.object.material.lighting(light, comps.over_point, comps.eyev, comps.normalv, shadowed) }
    @color = color_for_each_light.sum
  end
end