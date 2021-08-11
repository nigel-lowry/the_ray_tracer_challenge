class Pattern
  attr_reader :a, :b

  def self.stripe_pattern(a, b)
    new a, b
  end

  def stripe_at(point)
    point.x.floor % 2 == 0.0 ? a : b
  end

  def initialize(a, b)
    @a, @b = a, b
    freeze
  end
end