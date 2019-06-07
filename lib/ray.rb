require 'point'
require 'transform'

class Ray
  attr_reader :origin, :direction

  def initialize origin, direction
    @origin, @direction = origin, direction
  end

  def position t
    @origin + @direction * t
  end

  def transform m
    Ray.new(m * origin, m * direction)
  end
end