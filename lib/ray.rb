require 'point'

class Ray
  attr_reader :origin, :direction

  def initialize origin, direction
    @origin, @direction = origin, direction
  end
end