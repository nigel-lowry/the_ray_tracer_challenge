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

  def self.dot a, b
    a.x * b.x + a.y * b.y + a.z * b.z
  end

  def self.cross a, b
    Vector.new(a.y * b.z - a.z * b.y,
               a.z * b.x - a.x * b.z,
               a.x * b.y - a.y * b.x)
  end
end