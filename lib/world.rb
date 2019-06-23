class World
  attr_reader :objects, :light

  def initialize objects=[], light=nil
    @objects, @light = objects, light
  end

  def self.default
    new(nil, PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1)))
  end
end