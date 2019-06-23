require 'intersection'

class PrepareComputations
  attr_reader :t, :object, :point, :eyev, :normalv

  def initialize intersection, ray
    @t = intersection.t
    @object = intersection.object

    @point = ray.position(@t)
    @eyev = -ray.direction
    @normalv = @object.normal_at @point
  end
end