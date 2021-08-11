class AbstractPattern
  attr_reader :a, :b
  attr_accessor :transform

  def initialize(a, b)
    @a, @b = a, b
    @transform = Transform::IDENTITY
  end

end

class Pattern < AbstractPattern
  def self.stripe_pattern(a, b)
    new a, b
  end

  def initialize(a, b)
    super a, b
  end

  def stripe_at(point)
    point.x.floor % 2 == 0 ? a : b
  end

  def stripe_at_object(object, world_point)
    object_point = object.transform.inverse * world_point
    pattern_point = transform.inverse * object_point

    stripe_at(pattern_point)
  end
end