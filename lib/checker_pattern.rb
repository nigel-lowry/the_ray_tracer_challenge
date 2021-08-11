require 'pattern'

class CheckerPattern < Pattern
	def initialize(a:, b:)
    super a, b
  end

  def pattern_at(point)
    (point.x.floor + point.y.floor + point.z.floor) % 2 == 0 ? a : b
  end
end