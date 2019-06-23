class ShadeHit
  attr_reader :color

  def initialize world, comps
    @color = comps.object.material.lighting(world.light, comps.point, comps.eyev, comps.normalv)
  end
end