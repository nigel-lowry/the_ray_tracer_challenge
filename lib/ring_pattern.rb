class RingPattern < Pattern
  def initialize(a:, b:)
    super a, b
  end

  def pattern_at(point)
    Math.hypot(point.x, point.z).floor % 2 == 0 ? a : b
  end
end