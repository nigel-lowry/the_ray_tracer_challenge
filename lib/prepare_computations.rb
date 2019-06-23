require 'intersection'

class PrepareComputations
  attr_reader :t, :object, :point, :eyev, :normalv, :inside

  def initialize intersection, ray
    @t = intersection.t
    @object = intersection.object

    @point = ray.position(@t)
    @eyev = -ray.direction
    @normalv = @object.normal_at @point

    @inside = if Vector.dot(@normalv, @eyev) < 0
      @normalv = -@normalv
      true
    else
      false
    end
  end
end