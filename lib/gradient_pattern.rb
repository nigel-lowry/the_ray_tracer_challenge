require 'pattern'

class GradientPattern < Pattern
	def initialize(a, b)
    super
  end

  def pattern_at(point)
    distance = b - a
    fraction = point.x - point.x.floor

    a + distance * fraction
  end
end