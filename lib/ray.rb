require 'point'

class Ray
  attr_reader :origin, :direction

  def initialize origin, direction
    @origin, @direction = origin, direction
  end

  def position t
    @origin + @direction * t
  end
end