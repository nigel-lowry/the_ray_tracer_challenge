class World
  attr_reader :objects, :light_source

  def initialize objects=[], light_source=nil
    @objects, @light_source = objects, light_source
  end

  def self.default
    new(nil, PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1)))
  end
end