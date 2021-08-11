class Pattern
  attr_reader :a, :b
  attr_accessor :transform

  def initialize(a, b)
    @a, @b = a, b
    @transform = Transform::IDENTITY
  end

  def pattern_at_shape(object, world_point)
    object_point = object.transform.inverse * world_point
    pattern_point = transform.inverse * object_point

    pattern_at(pattern_point)
  end
end

class StripePattern < Pattern
  def initialize(a, b)
    super a, b
  end

  def pattern_at(point)
    stripe_at(point)
  end

  private

  def stripe_at(point)
    point.x.floor % 2 == 0 ? a : b
  end
end