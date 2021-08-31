require 'world'
require 'prepare_computations'

class ShadeHit
  attr_reader :color

  def initialize world, comps, remaining = 5
    shadowed = world.shadowed?(comps.over_point)
    surface = comps.object.material.lighting(comps.object, world.light, comps.over_point, comps.eyev, comps.normalv, shadowed)
    reflected = world.reflected_color(comps, remaining)

    @color = surface + reflected
  end
end