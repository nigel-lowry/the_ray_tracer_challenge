require 'tuple'

class Vector < Tuple
  def initialize x, y, z
    super(x, y, z, 0.0)
  end

  def magnitude
    Math.sqrt(@x ** 2 + @y ** 2 + @z ** 2)
  end

  def normalize
    v_magnitude = magnitude
    Vector.new(@x / magnitude, @y / magnitude, z / magnitude)
  end

  def unit_vector?
    magnitude == 1.0
  end
end