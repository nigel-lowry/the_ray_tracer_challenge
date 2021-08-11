require 'world'
require 'prepare_computations'

class ShadeHit
  attr_reader :color

  def initialize world, comps
    @color = comps.object.material.lighting(comps.object, world.light, comps.over_point, comps.eyev, comps.normalv, world.shadowed?(comps.over_point))
  end
end