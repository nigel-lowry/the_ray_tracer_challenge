require 'pattern'

class StripePattern < Pattern
  def initialize(a, b)
    super
  end

  def pattern_at(point)
    stripe_at(point)
  end

  private

  def stripe_at(point)
    point.x.floor % 2 == 0 ? a : b
  end
end